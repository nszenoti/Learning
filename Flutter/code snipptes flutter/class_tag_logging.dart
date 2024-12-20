//class_tag_logging.dart

import 'package:logger/logger.dart';

class CustomLogger {
  final Logger _logger = Logger();

  // Custom method to log with class name as the tag
  void logInfo(String message) {
    String className = _getClassName();
    _logger.i("[$className] $message");
  }

  void logError(String message) {
    String className = _getClassName();
    _logger.e("[$className] $message");
  }

  // Function to extract the class name from the stack trace
  String _getClassName() {
    // StackTrace.current will give the current call stack
    String traceString = StackTrace.current.toString();
    
    // Example log trace string: "#1 MyClass.myMethod (file.dart:line)"
    var classNameRegex = RegExp(r'#\d+\s+(\S+)\.');
    
    // Extract class name
    var match = classNameRegex.firstMatch(traceString);
    return match != null ? match.group(1) ?? "UnknownClass" : "UnknownClass";
  }
}

class MyClass {
  final CustomLogger logger = CustomLogger();

  void doSomething() {
    logger.logInfo("Doing something important.");
    logger.logError("An error occurred.");
  }
}

void main() {
  MyClass myClass = MyClass();
  myClass.doSomething();
}
