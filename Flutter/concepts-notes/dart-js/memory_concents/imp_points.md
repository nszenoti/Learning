imp_points

These sources collectively prove that Function.toJS creates wrappers with weak references, requiring explicit Dart-side retention via a registry like _callbacks.


Yes. They are Dart objects that act as lightweight proxies or handles, representing a real object that lives in the JavaScript heap.



