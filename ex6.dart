import 'dart:async';
void main() {
  print("Main program continues working...");

  // Asynchronous task
  Future.delayed(Duration(seconds: 2), () {
    print("Data Sent to server successfully!!!");
  });

  print("Connecting to server...");

  print("Server is running");
}