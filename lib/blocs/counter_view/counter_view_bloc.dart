import 'dart:async';
import 'package:channel_bloc/blocs/channel/channel_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:channel_bloc/blocs/channel/channel_bloc.dart';
import './bloc.dart';

class CounterViewBloc extends Bloc<CounterViewEvent, CounterViewState> {
  final int id, value;
  final ChannelBloc chanBloc;
  StreamSubscription chanSub;

  CounterViewBloc({@required this.chanBloc, this.id, this.value}) {
    chanSub = chanBloc.listen((state) {
      if (state is NotifyCounterUpdated) {
        add(UpdateCounter(id: state.id, value: state.value));
      }
    });
  }

  @override
  CounterViewState get initialState => CounterLoaded(id: id, value: value);

  @override
  Stream<CounterViewState> mapEventToState(CounterViewEvent event) async* {
    if (event is LoadCounter) {
      yield CounterLoaded(id: id, value: value);
    }
    if (event is UpdateCounter) {
      yield CounterLoaded(id: event.id, value: event.value);
    }
  }

  @override
  Future<void> close() {
    chanSub.cancel();
    return super.close();
  }
}
