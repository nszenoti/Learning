//getter_inherot_super.dart

void main() {
  var o = C2();
  print(o.props);
}

class Temp{
  List<int> get props => [];
}

class C1 implements Temp{
  @override
  List<int> get props => [1, 2];
}

class C2 extends C1{
  List<int> get props => [3, 4, ...super.props];
}