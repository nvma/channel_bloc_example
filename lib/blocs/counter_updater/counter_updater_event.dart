import 'package:meta/meta.dart';

@immutable
abstract class CounterUpdaterEvent {}

class UpdateCurrentCounterValue extends CounterUpdaterEvent {
  final int value;
  UpdateCurrentCounterValue({this.value});
}

class SubmitCounterValue extends CounterUpdaterEvent {}
