import 'dart:math';

/// Simulates realistic network latency for mock repositories.
///
/// Call [mockDelay] at the start of every mock repository method.
Future<void> mockDelay() {
  final ms = 300 + Random().nextInt(601); // 300–900 ms
  return Future<void>.delayed(Duration(milliseconds: ms));
}

/// Shorter delay for operations that should feel instant locally.
Future<void> mockShortDelay() {
  final ms = 100 + Random().nextInt(201); // 100–300 ms
  return Future<void>.delayed(Duration(milliseconds: ms));
}
