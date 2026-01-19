# file_download_v2

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

enum FileType { image, video, document }

class DownloadHelper {
  final Dio _dio = Dio();
  final MediaStore _mediaStore = MediaStore();

  /// Downloads a file based on type
  /// [url] → remote file url
  /// [fileName] → desired file name including extension
  /// [type] → FileType enum (image/video/document)
  /// Returns the saved file path (Android) or gallery confirmation (iOS)
  Future<String> downloadFile({
    required String url,
    required String fileName,
    required FileType type,
  }) async {
    if (type == FileType.image || type == FileType.video) {
      return _downloadMedia(url, fileName, type);
    } else {
      return _downloadDocument(url, fileName);
    }
  }

  /// Media download (image/video) using Gal
  Future<String> _downloadMedia(String url, String fileName, FileType type) async {
    // iOS and Android 10+ handle permissions automatically
    if (Platform.isAndroid && await _needsStoragePermission()) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception("Storage permission denied");
      }
    }

    final tempDir = await getTemporaryDirectory();
    final filePath = "${tempDir.path}/$fileName";

    // Download file to temp
    await _dio.download(url, filePath);

    // Save to gallery
    if (type == FileType.video) {
      await Gal.putVideo(filePath);
    } else {
      await Gal.putImage(filePath);
    }

    return filePath;
  }

  /// Document download (PDF, ZIP, DOCX, etc.)
  Future<String> _downloadDocument(String url, String fileName) async {
    final response = await _dio.get(url, options: Options(responseType: ResponseType.bytes));

    if (Platform.isAndroid) {
      // Request permission if Android < 10
      if (await _needsStoragePermission()) {
        final status = await Permission.storage.request();
        if (!status.isGranted) throw Exception("Storage permission denied");
      }
      // Save to Downloads folder
      return await _mediaStore.saveFile(
        fileName: fileName,
        relativePath: "Download",
        bytes: response.data,
      );
    } else if (Platform.isIOS) {
      // Save to app Documents folder
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/$fileName";
      final file = File(filePath);
      await file.writeAsBytes(response.data);
      return filePath;
    }

    throw UnsupportedError("Unsupported platform");
  }

  /// Checks if Android < 10 requires storage permission
  Future<bool> _needsStoragePermission() async {
    if (!Platform.isAndroid) return false;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt < 29;
  }
}
