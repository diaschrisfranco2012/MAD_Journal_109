import 'dart:async';
void main() {
  // Creates a normal stream (like 1,2,3,4,5 every 1 sec)
  Stream<int> numberStream = Stream.periodic(
    Duration(seconds: 1),
    (count) => count + 1,
  ).take(5);

  // Convert to broadcast stream
  var broadcastStream = numberStream.asBroadcastStream();

  print("Starting stream...\n");

  // Listener 1 -> Original values
  broadcastStream.listen((value) {
    print("Original: $value");
  });

  // Listener 2 -> Square values (using map)
  broadcastStream
   // map() → used to modify/transform each value of the stream
      .map((value) => value * value) 
      .listen((square) {
    print("Square: $square");
  });
}