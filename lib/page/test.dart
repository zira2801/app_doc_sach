// File: Test.dart

void main() {
  print('Hello, Dart!');

  // Example function call
  int sumResult = addNumbers(5, 3);
  print('Sum of 5 and 3 is: $sumResult');

  // Example class usage
  Person person = Person('John', 30);
  person.displayInfo();
}

// Function to add two numbers
int addNumbers(int a, int b) {
  return a + b;
}

// Example class
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void displayInfo() {
    print('Name: $name, Age: $age');
  }
}
