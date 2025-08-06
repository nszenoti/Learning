

# Using `js` and `flutter_js` Packages in Flutter Apps

Let me clarify how these packages help you use JavaScript in a cross-platform Flutter app without warnings:

## 1. The `js` Package

The `js` package is primarily for **annotation-based JS interop** and is most useful in web plugins. It doesn't actually solve the cross-platform issue on its own. If you use it directly in your app code, you'll still get the "web-only libraries" warning.

## 2. The `flutter_js` Package

The `flutter_js` package is what you're looking for. It provides a **cross-platform JavaScript runtime** that works on:
- Android (using QuickJS)
- iOS (using JavaScriptCore)
- Web (using the browser's JS engine)

Here's how to use it:

### Step 1: Add the dependency

```yaml
dependencies:
  flutter_js: ^0.8.0  # Check for the latest version
```

### Step 2: Create a JavaScript runtime

```dart
import 'package:flutter_js/flutter_js.dart';

// Create a JavaScript runtime
final jsRuntime = getJavascriptRuntime();
```

### Step 3: Execute JavaScript code

```dart
void executeJavaScript() {
  // Run JavaScript code
  final result = jsRuntime.evaluate('''
    function calculateTotal(items) {
      return items.reduce((sum, item) => sum + item.price, 0);
    }
    
    const items = [
      { name: "Product 1", price: 10 },
      { name: "Product 2", price: 20 }
    ];
    
    calculateTotal(items);
  ''');
  
  print('Result: ${result.stringResult}');
}
```

### Step 4: Pass data between Dart and JavaScript

```dart
void passDataToJs() {
  // Convert Dart data to JSON
  final items = [
    {'name': 'Product 1', 'price': 10},
    {'name': 'Product 2', 'price': 20}
  ];
  
  // Create a JavaScript function
  jsRuntime.evaluate('''
    function calculateTotal(items) {
      return items.reduce((sum, item) => sum + item.price, 0);
    }
  ''');
  
  // Call the function with Dart data
  final result = jsRuntime.evaluate(
    "calculateTotal(${jsonEncode(items)})"
  );
  
  print('Total: ${result.stringResult}');
}
```

### Step 5: For your word cloud example

```dart
import 'package:flutter_js/flutter_js.dart';
import 'dart:convert';
import '../models/word_meta.dart';

class WordCloudService {
  final JavascriptRuntime _jsRuntime = getJavascriptRuntime();
  
  WordCloudService() {
    // Load your word cloud JS code
    _jsRuntime.evaluate('''
      // Your word cloud layout algorithm in JavaScript
      function generateWordLayout(wordsJson, width, height) {
        const words = JSON.parse(wordsJson);
        // Your layout algorithm here
        const result = words.map(word => ({
          text: word.text,
          x: /* calculated x */,
          y: /* calculated y */,
          rotate: /* calculated rotation */
        }));
        return JSON.stringify(result);
      }
    ''');
  }
  
  Future<List<WordMeta>> generateWordCloudMetaData(
    List<WordMeta> words,
    double width,
    double height,
  ) async {
    final wordsJson = jsonEncode(words.map((w) => w.toJson()).toList());
    
    final result = _jsRuntime.evaluate(
      'generateWordLayout(\'$wordsJson\', $width, $height)'
    );
    
    final layoutData = jsonDecode(result.stringResult) as List;
    
    // Convert back to WordMeta objects
    return layoutData.map((item) {
      final word = words.firstWhere((w) => w.text == item['text']);
      return word.fromLayoutMeta(
        x: item['x'],
        y: item['y'],
        rotate: item['rotate'],
      );
    }).toList();
  }
}
```

## Benefits of `flutter_js`

1. **Cross-platform**: Works on all platforms Flutter supports
2. **No warnings**: Doesn't use web-only libraries directly
3. **Consistent API**: Same code works everywhere
4. **Performance**: Uses native JS engines on each platform
5. **Simplicity**: No need to create a separate plugin

## Limitations

1. **Bundle size**: Adds ~1-2MB to your app size
2. **Performance**: Not as fast as native web JS on web platforms
3. **API access**: Limited access to platform APIs compared to web JS
4. **JS libraries**: You need to bundle any JS libraries you want to use

This approach gives you a clean way to use JavaScript in your Flutter app without platform-specific code or warnings.
