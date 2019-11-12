import 'package:meta/meta.dart';

@immutable
abstract class CounterState {}

class InitialCounterState extends CounterState {}

class CountersReady extends CounterState {
  final List<Map<int, int>> counters;
  CountersReady({this.counters});
}
