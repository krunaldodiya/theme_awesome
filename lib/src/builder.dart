import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_theme/src/bloc.dart';
import 'package:awesome_theme/src/event.dart';
import 'package:awesome_theme/src/state.dart';

class AwesomeThemeBuilder extends StatefulWidget {
  AwesomeThemeBuilder({Key key, @required this.builder});

  final Function builder;

  @override
  _AwesomeThemeBuilderState createState() => _AwesomeThemeBuilderState();
}

class _AwesomeThemeBuilderState extends State<AwesomeThemeBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc dataBloc = BlocProvider.of(context);

    return BlocBuilder<ThemeEvent, ThemeState>(
      bloc: dataBloc,
      builder: (BuildContext context, ThemeState state) {
        return widget.builder(context, state);
      },
    );
  }
}
