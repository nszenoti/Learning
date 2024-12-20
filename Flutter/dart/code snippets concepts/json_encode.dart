//json_encode

import 'dart:convert';


class User {
  String name;
  int age;

  User(this.name, this.age);

  Map<String, dynamic> toJson() => {
        'namesdsds': name,
        'age': age,
      };
}

void main() {
  User user = User('Alice', 30);
  
  // This will call user.toJson() internally
  String jsonString = json.encode(user);
  
  print(jsonString); // Output: {"name":"Alice","age":30}
}
