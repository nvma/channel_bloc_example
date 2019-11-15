import 'package:channel_bloc/blocs/counter_view/counter_view_bloc.dart';
import 'package:channel_bloc/delegate.dart';
import 'package:channel_bloc/screens/counter_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'package:channel_bloc/blocs/channel/bloc.dart';
import 'package:channel_bloc/blocs/counter/bloc.dart';
import 'package:channel_bloc/blocs/counter_updater/bloc.dart';
import 'package:channel_bloc/screens/counter.dart';
import 'package:channel_bloc/screens/counter_updater.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  return runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ChannelBloc>(
          builder: (context) => ChannelBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chanBloc = BlocProvider.of<ChannelBloc>(context);
    return MaterialApp(
      title: 'Channel Bloc Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/counter_updater':
            return CupertinoPageRoute(builder: (ctx) {
              // Selected counter is passed via arguments with a signature of <id:value>.
              final args = settings.arguments as Map<int, int>;
              final id = args.keys.first;
              final value = args[id];
              return BlocProvider(
                builder: (context) => CounterUpdaterBloc(
                  id: id,
                  value: value,
                  chanBloc: chanBloc,
                ),
                child: CounterUpdaterScreen(),
              );
            });
          case '/counter_view':
            return CupertinoPageRoute(builder: (ctx) {
              // Selected counter is passed via arguments with a signature of <id:value>.
              final args = settings.arguments as Map<int, int>;
              final id = args.keys.first;
              final value = args[id];
              return BlocProvider(
                builder: (context) => CounterViewBloc(
                  id: id,
                  value: value,
                  chanBloc: chanBloc,
                ),
                child: CounterView(),
              );
            });
          default:
            return CupertinoPageRoute();
        }
      },
      home: BlocProvider(
        builder: (ctx) => CounterBloc(
          chanBloc: chanBloc,
        )..add(GenerateCounters()),
        child: CounterScreen(),
      ),
    );
  }
}
