

# Using JS Interop in Flutter Projects Correctly

If you're getting the warning "Don't use web-only libraries outside Flutter web plugins" when trying to use `js_util` or other web-specific libraries in your Flutter project, here's what you should do:

## The Correct Approach

1. **Create a Flutter Web Plugin**

   Instead of using web-specific libraries directly in your main app code, you should create a Flutter web plugin. This is the officially recommended approach.

2. **Steps to Create a Web Plugin**:

   a. **Create a plugin package**:
   ```bash
   flutter create --template=plugin --platforms=web my_web_plugin
   ```

   b. **Implement your JS interop code inside the plugin**:
   
   Inside your plugin, you can freely use `dart:js`, `dart:js_util`, and other web-specific libraries.

   c. **Create a platform interface** that defines methods your app will call.

   d. **Add the plugin to your main app** as a dependency.

## Example Implementation

Here's a simplified example:

1. **In your plugin's platform interface**:

```dart:packages/my_web_plugin/lib/my_web_plugin_platform_interface.dart
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class MyWebPluginPlatform extends PlatformInterface {
  MyWebPluginPlatform() : super(token: _token);
  
  static final Object _token = Object();
  static MyWebPluginPlatform _instance = WebUnsupportedPlatform();
  
  static MyWebPluginPlatform get instance => _instance;
  
  static set instance(MyWebPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
  
  Future<Map<String, dynamic>> callJsFunction(String functionName, List<dynamic> args) {
    throw UnimplementedError('callJsFunction() has not been implemented.');
  }
}

class WebUnsupportedPlatform extends MyWebPluginPlatform {
  @override
  Future<Map<String, dynamic>> callJsFunction(String functionName, List<dynamic> args) {
    throw UnsupportedError('JS interop is only supported on web platforms');
  }
}
```

2. **In your plugin's web implementation**:

```dart:packages/my_web_plugin/lib/my_web_plugin_web.dart
import 'dart:async';
import 'dart:js_util' as js_util;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'my_web_plugin_platform_interface.dart';

class MyWebPluginWeb extends MyWebPluginPlatform {
  static void registerWith(Registrar registrar) {
    MyWebPluginPlatform.instance = MyWebPluginWeb();
  }

  @override
  Future<Map<String, dynamic>> callJsFunction(String functionName, List<dynamic> args) async {
    try {
      final result = js_util.callMethod(js_util.globalThis, functionName, args);
      if (js_util.hasProperty(result, 'then')) {
        // Handle Promise
        final jsResult = await js_util.promiseToFuture(result);
        return _convertJsResult(jsResult);
      } else {
        // Handle non-Promise
        return _convertJsResult(result);
      }
    } catch (e) {
      throw Exception('Error calling JS function: $e');
    }
  }

  Map<String, dynamic> _convertJsResult(dynamic jsResult) {
    // Convert JS result to Dart Map
    // Implementation depends on your specific needs
    return {'result': jsResult.toString()};
  }
}
```

3. **In your main plugin file**:

```dart:packages/my_web_plugin/lib/my_web_plugin.dart
import 'my_web_plugin_platform_interface.dart';

class MyWebPlugin {
  Future<Map<String, dynamic>> callJsFunction(String functionName, List<dynamic> args) {
    return MyWebPluginPlatform.instance.callJsFunction(functionName, args);
  }
}
```

4. **In your main app**:

```dart:lib/main.dart
import 'package:my_web_plugin/my_web_plugin.dart';

final _webPlugin = MyWebPlugin();

// Later in your code:
void callJavaScript() async {
  try {
    final result = await _webPlugin.callJsFunction('myJsFunction', ['arg1', 42]);
    print('JS result: ${result['result']}');
  } catch (e) {
    print('Error: $e');
  }
}
```

## Alternative Approaches

If creating a plugin seems too complex for your needs:

1. **Use conditional imports** (less recommended but simpler):

```dart
import 'js_interop_stub.dart'
    if (dart.library.html) 'js_interop_web.dart';
```

2. **Use existing plugins** that already handle JS interop:
   - [js](https://pub.dev/packages/js)
   - [flutter_js](https://pub.dev/packages/flutter_js)

The plugin approach is the most "correct" way according to Flutter's architecture guidelines, as it properly isolates platform-specific code and ensures your app remains cross-platform compatible.
