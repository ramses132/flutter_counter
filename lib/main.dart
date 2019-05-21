import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'counter/counter.dart';
import 'theme/theme.dart';
import 'simple_bloc_delegate.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(CounterApp());
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  final CounterBloc _counterBloc = CounterBloc();
  final ThemeBloc _themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CounterBloc>(bloc: _counterBloc,),
        BlocProvider<ThemeBloc>(bloc: _themeBloc,)
      ],
      child: BlocBuilder(bloc: _themeBloc, builder: (_, ThemeData theme){
        return MaterialApp(
          title: 'Flutter BloC Demo',
          home: CounterPage(),
          theme: theme,
        );
      }),
    );

    return MaterialApp(
      title: 'Counter BloC Demo',
      home: BlocProvider<CounterBloc>(
        bloc: _counterBloc,
        child: CounterPage(),
      ),
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }
}
