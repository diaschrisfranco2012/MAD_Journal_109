Stream<int>countdown(){
  return Stream.periodic(
    Duration(seconds: 2),
    (count) => 1 + count,
  ).take(5);
}
void main() async{
  print("Countdown starting...");
  await for (int value in countdown()){
    print(value);
  }
  print('Time Up!');
}