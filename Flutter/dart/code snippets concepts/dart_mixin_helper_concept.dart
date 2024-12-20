//dart_mixin_helper_concept

/* Output
* ColorPrint :- My Name Shah
* My Name Shah
*/

void main() {
  const txt = 'My Name Shah';
  final hp = Hp('ColorPrint :-');
  final cn = Canon();
  hp.printme(txt);
  cn.printme(txt);
}

class Printer {
  void printme(String s) {
    print('$s');
  }
}

mixin ColorPrint on Printer {
  String? _txt;

  @override
  void printme(String o) {
    print('$_txt $o');
  }
}

class Canon extends Printer {
  
}

class Hp extends Printer with ColorPrint {
  Hp(this.text);

  String get _txt => text;
  final String text;
}
