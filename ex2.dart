import 'dart:io';
void main() {
  int choice;

  do {
    print('\n--- Calculator Menu ---');
    print('1. Add');
    print('2. Subtract');
    print('3. Multiply');
    print('4. Divide');
    print('5. Exit');
    print('Enter your choice:');

    choice = int.parse(stdin.readLineSync()!);

    if (choice >= 1 && choice <= 4) {
      print('Enter first number:');
      double? num1 = double.tryParse(stdin.readLineSync() ?? '');

      print('Enter second number:');
      double? num2 = double.tryParse(stdin.readLineSync() ?? '');
    

      if (num1 == null || num2 == null) {
        print('Invalid input!');
        continue;
      }

      switch (choice) {
        case 1:
          print('Result: ${num1 + num2}');
          break;

        case 2:
          print('Result: ${num1 - num2}');
          break;

        case 3:
          print('Result: ${num1 * num2}');
          break;

        case 4:
          if (num2 == 0) {
            print('Cannot divide by zero!');
          } else {
            print('Result: ${num1 / num2}');
          }
          break;
      }
    } else if (choice != 5) {
      print('Invalid choice!');
    }

  } while (choice != 5);

  print('Calculator closed.');
}