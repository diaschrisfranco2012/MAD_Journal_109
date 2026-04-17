void main() {
  List<int> evenNumbers = [];
  List<int> oddNumbers = [];

  // Loop through numbers 1 to 10
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
      evenNumbers.add(i); // It's even
    } else {
      oddNumbers.add(i);  // It's odd
    }
  }

  print('Even numbers: ${evenNumbers.join(', ')}');
  print('Odd numbers: ${oddNumbers.join(', ')}');
}