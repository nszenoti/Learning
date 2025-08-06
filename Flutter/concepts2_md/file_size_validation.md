file_size_validation.md

import 'package:file_picker/file_picker.dart';
import 'dart:io';

Future<void> pickFile() async {
  // Allowed extensions and max size in bytes
  const allowedExtensions = ['jpg', 'png', 'pdf']; // adjust as needed
  const maxFileSizeInMB = 5;
  const maxFileSizeInBytes = maxFileSizeInMB * 1024 * 1024;

  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedExtensions,
    withData: true, // needed if you want to use result.files.first.bytes
  );

  if (result != null && result.files.isNotEmpty) {
    final file = result.files.first;

    // Check extension
    final fileExtension = file.extension?.toLowerCase();
    if (fileExtension == null || !allowedExtensions.contains(fileExtension)) {
      print('❌ Invalid file type: $fileExtension');
      return;
    }

    // Check size (either use size or get from File if needed)
    final fileSize = file.size; // size in bytes
    if (fileSize > maxFileSizeInBytes) {
      print('❌ File too large: ${fileSize / (1024 * 1024)} MB');
      return;
    }

    print('✅ File is valid: ${file.name}, ${file.size} bytes');
    // Proceed with your logic (e.g., upload)
  } else {
    print('⚠️ File picking cancelled or failed');
  }
}
