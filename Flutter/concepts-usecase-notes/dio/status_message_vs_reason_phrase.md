In Dio, **there's no direct `reasonPhrase` property** like in `http` package. However, you can retrieve the equivalent **reason phrase** from the response headers using:

```dart
response.statusMessage
```

---

### **How to Use `statusMessage` in Dio**
```dart
try {
  Response response = await dio.get('https://example.com/data');

  if (response.statusCode != 200) {
    print("Error: ${response.statusCode} - ${response.statusMessage}");
  } else {
    print("Success: ${response.data}");
  }
} catch (e) {
  print("Request failed: $e");
}
```

🔹 `response.statusMessage` is similar to `http`'s `reasonPhrase`.
🔹 **Example Output for 404:** `"Error: 404 - Not Found"`

---

### **How to Handle `statusMessage` in an API Wrapper**
If you're abstracting Dio, you can include `statusMessage` in error handling:

```dart
Future<dynamic> handleResponse(Response response) {
  if (response.statusCode == 200) {
    return response.data;
  } else {
    throw DioException(
      "Error: ${response.statusCode} - ${response.statusMessage}",
    );
  }
}
```

Would you like me to help with **a structured error-handling approach for Dio**? 🚀