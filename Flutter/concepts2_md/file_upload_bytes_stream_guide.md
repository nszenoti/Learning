# file_upload_bytes_stream_guide

Perfect — since you're sending **raw `Uint8List` file bytes** in a **`PUT` request** using Dio, here's **exactly how to do it right**, and **when you need `requestEncoder`**.

---

### ✅ Option 1: Simple & Safe Way (with `requestEncoder`)

Use this if you **want to be 100% safe** and prevent Dio from trying to `jsonEncode` your bytes (which it does by default for non-string/non-stream data).

```dart
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';

Future<void> uploadRawBytes(Uint8List bytes) async {
  final dio = Dio();

  await dio.put(
    'https://your.api/endpoint',
    data: bytes,
    options: Options(
      contentType: 'application/octet-stream',
      headers: {
        Headers.contentLengthHeader: bytes.length,
      },
      requestEncoder: (dynamic data, RequestOptions options) {
        // Prevent Dio from applying default encoding (like jsonEncode)
        return data; // must be List<int> or Stream<List<int>>
      },
    ),
    onSendProgress: (sent, total) {
      print('Progress: $sent / $total');
    },
  );
}
```

---

### ✅ Option 2: Advanced — Send as `Stream.fromIterable`

If you want to **stream** the data (e.g., to support very large files or chunked transfer), use:

```dart
Stream<List<int>> byteStream = Stream.fromIterable([bytes]);

await dio.put(
  'https://your.api/endpoint',
  data: byteStream,
  options: Options(
    contentType: 'application/octet-stream',
    headers: {
      Headers.contentLengthHeader: bytes.length,
    },
  ),
);
```

---

### 🔍 Why is `requestEncoder` Needed with `Uint8List`?

By default, Dio will try to:

* Call `jsonEncode(data)` on any object that isn’t `String`, `FormData`, or `Stream`
* This breaks binary data like `Uint8List` — it will fail or corrupt the request

So you **must use `requestEncoder`** when directly passing `Uint8List`.

---

### 🚫 Don’t Use This (Common Mistake)

```dart
// This might crash or send invalid data
dio.put(
  'https://example.com/upload',
  data: fileBytes,
);
```

This fails because Dio tries to encode the bytes as JSON — leading to:

* Crashes (`Expected a value of type String`)
* Corrupted request body

---

### ✅ Final Recommendation for 5MB File

Since your file is:

* **Small enough** to load in memory (5MB)
* Sent as **raw binary**

Use **Option 1** with `requestEncoder`. It's clean, efficient, and safe.

---

Let me know if the server expects `multipart/form-data` or if you're passing metadata (filename, mime type), and I’ll adapt the code for that.
