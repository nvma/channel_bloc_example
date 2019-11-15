import 'package:meta/meta.dart';

@immutable
abstract class CounterViewEvent {}

class LoadCounter extends CounterViewEvent {
  LoadCounter();
}

class UpdateCounter extends CounterViewEvent {
  final int id, value;
  UpdateCounter({this.id, this.value});
}
