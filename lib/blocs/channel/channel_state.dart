import 'package:meta/meta.dart';

@immutable
abstract class ChannelState {}

class InitialChannelState extends ChannelState {}

class NotifyCounterUpdated extends ChannelState {
  final int id, value;
  NotifyCounterUpdated({this.id, this.value});
}
