class Employee {
  String _name;
  double _hourlyRate;

  // Constructor
  Employee(this._name, this._hourlyRate);

  // Setter 
  void set hourlyRate(double value) {
    if (value >= 0) {
      _hourlyRate = value;
    } else {
      _hourlyRate = 0.0;
      print('Warning: Enter a positive value');
    }
  }

  // Getter 
  double get yearlySalary {
    return 2028 * _hourlyRate;
  }

  void display() {
    print("Name: $_name");
    print("Hourly Rate: $_hourlyRate");
    print("Yearly Salary: $yearlySalary");
    print("----------------------");
  }
}

void main() {
  Employee e1 = Employee("John Doe", 10.0);
  e1.hourlyRate = 50.0;

  Employee e2 = Employee("Jane Smith", 10.0);
  e2.hourlyRate = -20.0;

  e1.display();
  e2.display(); 
}
