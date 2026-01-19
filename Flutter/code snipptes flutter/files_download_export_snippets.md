# files_download_export_snippets

import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// Downloads and exports a file (image/docs) so it's visible to the user
Future<void> exportFile(String url, {String? filename, bool isImage = false}) async {
  final dio = Dio();

  // 1. Download bytes
  final response = await dio.get<List<int>>(
    url,
    options: Options(responseType: ResponseType.bytes),
  );
  final Uint8List bytes = Uint8List.fromList(response.data!);

  if (Platform.isAndroid) {
    // --- ANDROID ---
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt <= 28) {
      // Android 9 and below → need WRITE permission
      if (!await Permission.storage.request().isGranted) {
        throw Exception("Storage permission denied");
      }
      // Save to Downloads directory
      final downloads = Directory('/storage/emulated/0/Download');
      final file = File("${downloads.path}/${filename ?? 'file_${DateTime.now().millisecondsSinceEpoch}'}");
      await file.writeAsBytes(bytes);
      print("✅ Saved to Downloads: ${file.path}");
    } else {
      // Android 10+ → Scoped storage, use MediaStore-compatible saver
      if (isImage) {
        await ImageGallerySaver.saveImage(bytes, name: filename);
        print("✅ Saved image to gallery");
      } else {
        // Fallback: save in app documents (visible via share/export later)
        final dir = await getApplicationDocumentsDirectory();
        final file = File("${dir.path}/${filename ?? 'file_${DateTime.now().millisecondsSinceEpoch}'}");
        await file.writeAsBytes(bytes);
        print("✅ Saved doc to app storage: ${file.path}");
      }
    }
  } else if (Platform.isIOS) {
    // --- iOS ---
    if (isImage) {
      if (!await Permission.photos.request().isGranted) {
        throw Exception("Photos permission denied");
      }
      await ImageGallerySaver.saveImage(bytes, name: filename);
      print("✅ Saved image to Photos app");
    } else {
      // Save documents in app’s sandbox (visible via Files app)
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/${filename ?? 'file_${DateTime.now().millisecondsSinceEpoch}'}");
      await file.writeAsBytes(bytes);
      print("✅ Saved document to iOS Files app: ${file.path}");
    }
  } else {
    throw UnsupportedError("Only Android & iOS supported");
  }
}
