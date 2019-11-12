import 'package:channel_bloc/blocs/counter_updater/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterUpdaterScreen extends StatelessWidget {
  const CounterUpdaterScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _updaterBloc = BlocProvider.of<CounterUpdaterBloc>(context);
    return BlocBuilder<CounterUpdaterBloc, CounterUpdaterState>(
      builder: (context, state) {
        final value = (state as CurrentState).currentCounterValue;
        return Scaffold(
          appBar: AppBar(
            title: Text("Updater for counter #${_updaterBloc.id}"),
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 50)),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.pink,
                      onPressed: () {
                        _updaterBloc.add(
                          UpdateCurrentCounterValue(value: value - 1),
                        );
                      },
                    ),
                    Text(
                      "Current value $value",
                      style: Theme.of(context).textTheme.headline,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.pink,
                      onPressed: () {
                        _updaterBloc
                            .add(UpdateCurrentCounterValue(value: value + 1));
                      },
                    ),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 50)),
              RaisedButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                color: Colors.pink,
                child: Text(
                  "SAVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  _updaterBloc.add(SubmitCounterValue());
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
