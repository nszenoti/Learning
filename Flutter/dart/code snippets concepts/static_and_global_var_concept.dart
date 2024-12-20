//static_and_global_var_concept.dart

/// a good example for dart concepts brusher

void main() {
  print('Hiii');
  initEnv();
  Utils.check();
}

class Env {
  final String val; 
  Env(this.val); 
}

// late is allowed on global scoped variables as well in dart
late Env env; 
void initEnv(){
  env = Env('one');
}

class Utils {
  static void check(){
    // this allowed as check() will gain memory in heap when its invoked & not when defined !!
    // Hence env.val is allowed at compile time despite check() being static
    print(env.val);
  }
}
