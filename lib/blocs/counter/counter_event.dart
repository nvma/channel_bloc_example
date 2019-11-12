import 'package:meta/meta.dart';

@immutable
abstract class CounterEvent {}

class GenerateCounters extends CounterEvent {}

class FindAndUpdateCounter extends CounterEvent {
  final int id, value;
  FindAndUpdateCounter({this.id, this.value});
}
