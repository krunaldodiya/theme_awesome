import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_theme/src/event.dart';
import 'package:awesome_theme/src/state.dart';
import 'package:awesome_theme/src/theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState();

  void registerApp({String secretKey}) async {
    dispatch(RegisterApp(secretKey: secretKey));
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is RegisterApp) {
      await setKey("secretKey", event.secretKey);
      dispatch(FetchTheme());
    }

    if (event is FetchTheme) {
      Map themeData = await getThemeData();

      yield ThemeState(theme: ThemeOption().set(themeData: themeData));
    }

    if (event is RefreshTheme) {
      await getRemoteTheme();
      dispatch(FetchTheme());
    }
  }

  Future getThemeData() async {
    final theme = await getKey("defaultTheme");
    return theme != null ? getLocalTheme() : getRemoteTheme();
  }

  Future getLocalTheme() async {
    final defaultTheme = await getKey("defaultTheme");
    return json.decode(defaultTheme);
  }

  Future getRemoteTheme() async {
    final secretKey = await getKey("secretKey");

    if (secretKey != null) {
      final url = "http://bfbadf8b.ngrok.io/project/$secretKey";
      final response = await http.get(url);

      await setKey("defaultTheme", response.body);
      final defaultTheme = await getKey("defaultTheme");

      return json.decode(defaultTheme);
    } else {
      print("Waiting for secret key");
    }
  }

  Future setKey(key, value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  Future getKey(key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }
}
