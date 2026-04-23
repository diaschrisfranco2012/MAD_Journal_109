import 'dart:async';

Stream<int> countdown() {
  return Stream.periodic(
    Duration(seconds: 2),
    (count) => count + 1,
  ).take(5);
}

void main() {
  print("Countdown starting...");

  countdown().listen(
    (value) {
      print(value);
    },
    onDone: () {
      print("Time Up!");
    },
    onError: (error) {
      print("Error: $error");
    },
  );
}