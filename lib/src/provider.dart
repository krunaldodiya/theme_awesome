import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_theme/src/bloc.dart';
import 'package:awesome_theme/src/event.dart';

class AwesomeThemeProvider extends StatefulWidget {
  AwesomeThemeProvider(
      {Key key, @required this.child, @required this.secretKey});

  final Widget child;
  final String secretKey;

  @override
  _AwesomeThemeProviderState createState() => _AwesomeThemeProviderState();
}

class _AwesomeThemeProviderState extends State<AwesomeThemeProvider> {
  final ThemeBloc _themeBloc = ThemeBloc();

  @override
  void initState() {
    super.initState();
    _themeBloc.registerApp(secretKey: widget.secretKey);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (data) {
        return AlertDialog(
          title: Text("Refresh Theme"),
          content: Text("Do you want to refresh ?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "CANCEL",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                _themeBloc.dispatch(RefreshTheme());
              },
              child: Text(
                "OKAY",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _themeBloc,
      child: GestureDetector(
        onLongPress: _showDialog,
        child: widget.child,
      ),
    );
  }
}
