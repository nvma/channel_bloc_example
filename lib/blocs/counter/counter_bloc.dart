import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:channel_bloc/blocs/channel/bloc.dart';
import './bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final ChannelBloc chanBloc;
  StreamSubscription chanSub;

  CounterBloc({@required this.chanBloc}) {
    chanSub = chanBloc.listen((state) {
      if (state is NotifyCounterUpdated) {
        add(FindAndUpdateCounter(id: state.id, value: state.value));
      }
    });
  }

  @override
  CounterState get initialState => InitialCounterState();

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is GenerateCounters) {
      yield CountersReady(counters: _generateCounters(10));
    }

    if (event is FindAndUpdateCounter) {
      final counters = (state as CountersReady).counters;
      yield CountersReady(
          counters: counters.map((c) {
        if (c.keys.first == event.id) return {event.id: event.value};
        return c;
      }).toList());
    }
  }

  List<Map<int, int>> _generateCounters(int n) {
    final List<Map<int, int>> out = [];
    for (var i = 0; i < 5; i++) {
      out.add({i + 1: (i + 1) * 2});
    }
    return out;
  }

  @override
  Future<void> close() {
    chanSub.cancel();
    return super.close();
  }
}
