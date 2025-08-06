



In Dio, when using `ResponseType.stream`, the type of `response.data!.stream` is always `Stream<Uint8List>`. Here's a breakdown:

```dart
final response = await _dio.get<ResponseBody>(
  path,
  options: Options(responseType: ResponseType.stream)
);

// response.data is ResponseBody
// response.data!.stream is Stream<Uint8List>

// Example usage:
await for (Uint8List chunk in response.data!.stream) {
  // Each chunk is Uint8List
}
```

This is consistent regardless of:
- The content type of the response
- The type of data being streamed (file, JSON, text, etc.)
- The size of the response

The server's response is always broken into chunks of bytes (Uint8List), which you can then process based on your needs (like converting to string, parsing JSON, saving as file, etc.).
