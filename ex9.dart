import 'dart:async';

void main() {
  // Create temperature stream (Celsius)
  Stream<int> tempStream = Stream.periodic(
    Duration(seconds: 1),
    (count) => 25 + count, // 25, 26, 27...
  ).take(5);

  // Convert to broadcast stream
  var broadcastStream = tempStream.asBroadcastStream();

  // Listener 1: Raw temperature (with filtering)
  broadcastStream
      .where((temp) => temp >= 26) // filter
      .listen((temp) {
    print("Celsius: $temp°C");
  });

  // Listener 2: Convert to Fahrenheit (using map)
  broadcastStream
      .map((temp) => (temp * 9 / 5) + 32) // conversion
      .listen((tempF) {
    print("Fahrenheit: $tempF°F");
  });
}