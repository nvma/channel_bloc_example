import 'package:channel_bloc/blocs/counter/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select counter to update"),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is InitialCounterState) return Container();
          final data = (state as CountersReady).counters;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final counter = data[index];
              final id = counter.keys.first;
              final value = counter[id];
              return ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    "/counter_view",
                    arguments: {id: value},
                  );
                },
                title: Text("Counter #$id"),
                trailing: Text('$value', style: TextStyle(fontSize: 25)),
              );
            },
          );
        },
      ),
    );
  }
}
