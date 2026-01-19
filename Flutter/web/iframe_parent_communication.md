# iframe_parent_communication.md

Yes! You can communicate between a parent web app and an iframe-embedded web app using the **`postMessage` API**. Here's how to implement it in Flutter Web:

## 1. Parent → Child Communication (WebApp1 → WebApp2)

### In WebApp1 (Parent)
```dart
import 'dart:html' as html;
import 'dart:js' as js;

class IframeComm {
  final html.IFrameElement iframe;

  IframeComm(this.iframe);

  void sendToChild(String message) {
    // Replace with your WebApp2's actual origin
    final targetOrigin = 'https://webapp2.yourdomain.com';
    
    iframe.contentWindow?.postMessage(message, targetOrigin);
    
    // For JSON data:
    // iframe.contentWindow?.postMessage(json.encode(data), targetOrigin);
  }
}

// Usage in your Flutter widget:
// final iframe = html.IFrameElement()
//   ..src = 'https://webapp2.yourdomain.com'
//   ..style.border = 'none';
// ui.platformViewRegistry.registerViewFactory(
//   'iframe',
//   (int viewId) => iframe,
// );
```

### In WebApp2 (Child - iframe)
```dart
import 'dart:html' as html;

class ParentMessageListener {
  static void listen() {
    html.window.onMessage.listen((event) {
      // CRITICAL: Verify origin for security!
      if (event.origin != 'https://webapp1.yourdomain.com') {
        print('⚠️ Unauthorized origin: ${event.origin}');
        return;
      }

      final message = event.data as String;
      print('📨 Received from parent: $message');
      
      // Handle the message
      _processMessage(message);
    });
  }

  static void _processMessage(String message) {
    // Your logic here
    if (message == 'clear-data') {
      // Clear Hive boxes, etc.
    }
  }
}

// Call in main() or app initialization:
void main() {
  ParentMessageListener.listen();
  runApp(MyApp());
}
```

## 2. Child → Parent Communication (WebApp2 → WebApp1)

### In WebApp2 (Child)
```dart
class ChildComm {
  void sendToParent(String message) {
    // Use '*' for unknown parent origin or specify exact origin
    html.window.parent?.postMessage(message, '*');
    
    // Better: Specify exact origin
    // html.window.parent?.postMessage(message, 'https://webapp1.yourdomain.com');
  }
}
```

### In WebApp1 (Parent)
```dart
class ChildMessageListener {
  static void listen() {
    html.window.onMessage.listen((event) {
      // Verify the message is from your iframe
      if (event.origin != 'https://webapp2.yourdomain.com') {
        return;
      }

      final message = event.data as String;
      print('📨 Received from child iframe: $message');
      
      // Handle response
    });
  }
}
```

## 3. JSON Data Communication

**WebApp1 → WebApp2:**
```dart
final data = {
  'action': 'clear-storage',
  'boxes': ['user', 'cache']
};
iframe.contentWindow?.postMessage(json.encode(data), targetOrigin);
```

**WebApp2 receiving:**
```dart
html.window.onMessage.listen((event) {
  final data = json.decode(event.data as String);
  if (data['action'] == 'clear-storage') {
    // Clear specified boxes
  }
});
```

## 4. Two-Way Communication with Response

**WebApp1 (request with callback):**
```dart
void queryChildData() {
  // Send a message with a request ID
  final request = {
    'id': 'req-123',
    'action': 'get-user-data'
  };
  iframe.contentWindow?.postMessage(json.encode(request), targetOrigin);
}

// Listen for responses
html.window.onMessage.listen((event) {
  if (event.origin != webApp2Origin) return;
  
  final response = json.decode(event.data as String);
  if (response['requestId'] == 'req-123') {
    print('Got response: ${response['data']}');
  }
});
```

**WebApp2 (handle and respond):**
```dart
html.window.onMessage.listen((event) {
  final request = json.decode(event.data as String);
  
  if (request['action'] == 'get-user-data') {
    final response = {
      'requestId': request['id'],
      'data': await _getUserData() // Your function
    };
    event.source?.postMessage(json.encode(response), event.origin);
  }
});
```

## 5. Flutter Widget Integration

```dart
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class IframeEmbed extends StatefulWidget {
  @override
  _IframeEmbedState createState() => _IframeEmbedState();
}

class _IframeEmbedState extends State<IframeEmbed> {
  final _iframe = html.IFrameElement()
    ..src = 'https://webapp2.yourdomain.com'
    ..style.border = 'none'
    ..style.width = '100%'
    ..style.height = '100%';

  @override
  void initState() {
    super.initState();
    // Start listening for messages from child
    ChildMessageListener.listen();
    
    // Register iframe
    ui.platformViewRegistry.registerViewFactory(
      'webapp2-iframe',
      (int viewId) => _iframe,
    );
  }

  void _clearChildData() {
    final comm = IframeComm(_iframe);
    comm.sendToChild('clear-storage');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _clearChildData,
          child: Text('Clear Child App Data'),
        ),
        Expanded(
          child: HtmlElementView(viewType: 'webapp2-iframe'),
        ),
      ],
    );
  }
}
```

## Security Best Practices ⚠️

1. **Always verify `event.origin`** - Never trust messages from unknown origins
2. **Validate message structure** - Check for expected fields/types
3. **Use HTTPS only** - In production, enforce secure origins
4. **Consider using tokens** for sensitive operations
5. **Avoid `'*'`** as target origin in production - specify exact origins

This approach is standard for cross-origin iframe communication and works perfectly with Flutter Web apps!