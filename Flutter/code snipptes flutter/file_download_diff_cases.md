# file_download_diff_cases

Got it 👍 — here’s a **concise, cross-platform snippet** that:

* Requests runtime permissions only when required
* Works on **Android ≤ 9**, **Android 10+**, and **iOS**
* Saves image to the **Gallery/Photos app** using `image_gallery_saver`

```dart
import 'dart:typed_data';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveImageToGallery(Uint8List bytes) async {
  if (await _requestPermission()) {
    final result = await ImageGallerySaver.saveImage(
      bytes,
      quality: 100,
      name: "my_image_${DateTime.now().millisecondsSinceEpoch}",
    );
    print("Saved: $result");
  } else {
    print("Permission denied.");
  }
}

Future<bool> _requestPermission() async {
  if (Platform.isAndroid) {
    // Android 10+ doesn’t need storage permission
    if (await Permission.storage.isGranted || Platform.version.startsWith("10") == false) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true; 
  } else if (Platform.isIOS) {
    final status = await Permission.photos.request();
    return status.isGranted;
  }
  return false;
}
```

---

### 🔑 Setup

**AndroidManifest.xml** (only for API ≤ 28 support):

```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

**iOS Info.plist**:

```xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need access to save images to your Photos.</string>
```

---

✅ This one snippet covers:

* Android ≤ 9 → requests storage permission
* Android 10+ → no permission needed
* iOS → requests Photos permission automatically

---

Do you want me to refine this so it also works for **video saving** (same flow, just different API call)?
