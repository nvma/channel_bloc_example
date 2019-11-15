import 'package:meta/meta.dart';

@immutable
abstract class CounterViewState {}

class InitialCounterViewState extends CounterViewState {}

class CounterLoaded extends CounterViewState {
  final int id, value;
  CounterLoaded({this.id, this.value});
}
