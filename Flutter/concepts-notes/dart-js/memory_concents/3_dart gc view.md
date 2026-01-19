# 3_dart gc view

// dartApp['callback'] = jsFunc 
// Stores a POINTER in JS heap, not a reference Dart GC can trace

// Dart GC: "I see 0 references to jsFunc" → COLLECTS IT

// _callbacks['callback'] = jsFunc  
// Stores a REFERENCE in Dart heap that Dart GC CAN trace

// Dart GC: "1 reference to jsFunc" → KEEPS IT ALIVE



--------------------



// 1. Create Dart function (Dart heap)
final callback = () => print('hi'); 

// 2. toJS creates wrapper with WEAK reference
final jsFunc = callback.toJS; // Weak ref doesn't keep callback alive

// 3. Store pointer in JS object (JS heap)
globalContext['callback'] = jsFunc; // Stores 0x12345678, not object

// 4. Dart GC: callback has 0 strong refs → COLLECTED
// 5. JS calls 0x12345678 → CRASH (memory freed)