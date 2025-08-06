



For sending raw bytes (Uint8List) in a POST request with Dio, you can do it directly:

```dart:lib/core/client/dio_client.dart
class DioClient implements Client {
  @override
  Future<Response> uploadBytes({
    required String path,
    required Uint8List bytes,  // Changed to Uint8List
    String? contentType,
    void Function(int, int)? onSendProgress,
  }) async {
    return _dio.post(
      path,
      data: bytes,  // Dio handles Uint8List directly
      options: Options(
        headers: {
          if (contentType != null) 'Content-Type': contentType,
        },
      ),
      onSendProgress: onSendProgress,
    );
  }
}
```

The key differences:
- http package: `request.bodyBytes = bytes`
- Dio: `data: bytes` directly in the post method

Both achieve the same result - sending raw bytes in the request body. Dio handles the Uint8List serialization internally.
