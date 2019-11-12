import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:channel_bloc/blocs/channel/bloc.dart';
import './bloc.dart';

class CounterUpdaterBloc
    extends Bloc<CounterUpdaterEvent, CounterUpdaterState> {
  final int id, value;
  final ChannelBloc chanBloc;
  CounterUpdaterBloc({
    @required this.id,
    @required this.value,
    @required this.chanBloc,
  });

  @override
  CounterUpdaterState get initialState =>
      CurrentState(currentCounterValue: value);

  @override
  Stream<CounterUpdaterState> mapEventToState(
      CounterUpdaterEvent event) async* {
    if (event is UpdateCurrentCounterValue) {
      yield CurrentState(currentCounterValue: event.value);
    }
    if (event is SubmitCounterValue) {
      final currentValue = (state as CurrentState).currentCounterValue;
      chanBloc.add(DispatchCounterUpdated(id: id, value: currentValue));
    }
  }
}
