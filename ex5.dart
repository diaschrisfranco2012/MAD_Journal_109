import 'dart:io';

void main() {
  try {
    print("Enter a numerical ID:");

    String? input = stdin.readLineSync();

    // Check for null or empty input
    if (input == null || input.isEmpty) {
      throw FormatException("Input cannot be empty");
    }

    int id = int.parse(input);

    print("Valid ID entered: $id");
  } 

  // Handle invalid number format
  on FormatException catch (e) {
    print("Error: Invalid input! Please enter a valid number.");
    print("Details: ${e.message}");
  } 

  // other unexpected errors
  catch (e) {
    print("Unexpected error occurred: $e");
  } 

  // Always executes
  finally {
    print("Program execution completed.");
  }
}