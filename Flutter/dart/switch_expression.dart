void main() {
  Vehicle v = Car('nano');
  final n = switch(v){
      Vehicle() && Nano() => v.name, 
      _ => 'sdsd'
  };
  print(n);
}


class Vehicle {
  final String name; 
  
  Vehicle(this.name);
}

class Car extends Vehicle {
   Car(super.name);
}

class Nano extends Car {
  Nano(super.name);
}

class Bike extends Vehicle {
  Bike(super.name);
}