import 'dart:async';

Future<String> fetchUserData() async {
  print("Fetching user data...");
  
  await Future.delayed(Duration(seconds: 3));
  
  return "User data received!";
}

void main() async {
  print("Program started");

  String result = await fetchUserData();

  print(result);

  print("Program ended");
}