import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  @override
  ChannelState get initialState => InitialChannelState();

  @override
  Stream<ChannelState> mapEventToState(ChannelEvent event) async* {
    if (event is DispatchCounterUpdated) {
      yield NotifyCounterUpdated(id: event.id, value: event.value);
    }

    // Reset Channel state;
    yield InitialChannelState();
  }
}
