//runtimetype_inheritance

void main() {
  Metal m = Iron(); 
  m.printThis();  // Iron
}

abstract class Metal {
  void printThis(){
    print(this.runtimeType.toString());
  }
}

class Iron extends Metal {
  Iron(); 
} 