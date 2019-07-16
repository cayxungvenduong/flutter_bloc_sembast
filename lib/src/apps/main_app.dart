import 'package:flutter/material.dart';
import 'package:flutter_app/src/components/home_page.dart';
import 'package:flutter_app/src/fruit_blocs/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FruitBloc>(
      builder: (context) => FruitBloc(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
