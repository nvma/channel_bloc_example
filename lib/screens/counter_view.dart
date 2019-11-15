import 'package:channel_bloc/blocs/counter_view/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _viewBloc = BlocProvider.of<CounterViewBloc>(context);
    return BlocBuilder<CounterViewBloc, CounterViewState>(
      builder: (context, state) {
        final value = (state as CounterLoaded).value;
        return Scaffold(
          appBar: AppBar(
            title: Text("View for counter #${_viewBloc.id}"),
            backgroundColor: Colors.black,
          ),
          body: RefreshIndicator(
            onRefresh: () {
              _viewBloc.add(LoadCounter());
              return Future.value(1);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 50)),
                  Center(
                    child: Text(
                      "Counter value is $value",
                      style: Theme.of(context).textTheme.headline,
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
                      "UPDATE COUNTER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        "/counter_updater",
                        arguments: {_viewBloc.id: _viewBloc.value},
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
