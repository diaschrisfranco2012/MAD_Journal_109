class Employee {
  late String _name;
  late double _hourlyRate;

  // Constructor
  Employee(this._name, this._hourlyRate);

  // Setter with validation
  void set hourlyRate(double value) {
    if (value >= 0) {
      _hourlyRate = value;
    } else {
      _hourlyRate = 0.0;
      print('\nWarning: Enter a positive value');
    }
  }

  // Getter
  double get yearlySalary {
    return 2080 * _hourlyRate;
  }

  void display() {
    print("Employee name is $_name");
    print("Employee hourly rate is $_hourlyRate");
    print("Employee yearly salary is $yearlySalary");
  }
}

void main() {
  Employee e1 = Employee("John Doe", 10.0);
  e1.hourlyRate = 50.0;
  e1.display();

  Employee e2 = Employee("Jane Smith", 10.0);
  e2.hourlyRate = -20.0;
  e2.display();
}
