import 'package:meta/meta.dart';

@immutable
abstract class CounterUpdaterState {}

class CurrentState extends CounterUpdaterState {
  final int currentCounterValue;
  CurrentState({this.currentCounterValue});
}
