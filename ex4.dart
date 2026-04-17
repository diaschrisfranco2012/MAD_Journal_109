abstract class Vehicle {
  String make;
  String model;

  // Constructor
  Vehicle(this.make, this.model);

  // Abstract method
  void startEngine();

  // Concrete method
  void displayInfo() {
    print("Make: $make");
    print("Model: $model");
  }
}

// Car class
class Car extends Vehicle {
  int numberOfDoors;

  Car(String make, String model, this.numberOfDoors)
      : super(make, model);

  @override
  void startEngine() {
    print("\n--- Car ---");
    displayInfo();
    print("Doors: $numberOfDoors");
    print("Car engine started!");
  }
}

// Motorcycle class
class Motorcycle extends Vehicle {
  bool hasSideCar;

  Motorcycle(String make, String model, this.hasSideCar)
      : super(make, model);

  @override
  void startEngine() {
    print("\n--- Motorcycle ---");
    displayInfo();
    print("Has Sidecar: $hasSideCar");
    print("Motorcycle engine started!");
  }
}

void main() {
  List<Vehicle> vehicles = [
    Car("BMW", "e30", 4),
    Motorcycle("Ducati", "StreetFighter v4s", false)
  ];

  for (var v in vehicles) {
    v.startEngine();   
  }
}