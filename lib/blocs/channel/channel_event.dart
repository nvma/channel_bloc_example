import 'package:meta/meta.dart';

@immutable
abstract class ChannelEvent {}

class DispatchCounterUpdated extends ChannelEvent {
  final int id, value;
  DispatchCounterUpdated({this.id, this.value});
}
