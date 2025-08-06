dio_dart_concepts

Yes, that's correct! When using Dio, any HTTP response with a status code >= 400 (including 501) will automatically be converted into a `DioException` by Dio. 

Here's how it works:
1. Dio considers any status code >= 400 as an error response
2. When it receives such a response, it throws a `DioException`
3. The original response is preserved in the `DioException.response` property
4. We can access the status code via `error.response?.statusCode`

That's why in our code we:
1. Catch `DioException`
2. Check `error.response?.statusCode == 501`
3. Handle it specially by returning empty data
4. Let other error status codes propagate up by using `rethrow`

This is different from some other HTTP clients where you might need to manually check status codes. Dio makes it explicit by throwing exceptions for non-2xx responses.