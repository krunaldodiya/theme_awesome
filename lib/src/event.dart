abstract class ThemeEvent {}

class FetchTheme extends ThemeEvent {}

class RefreshTheme extends ThemeEvent {}

class RegisterApp extends ThemeEvent {
  String secretKey;

  RegisterApp({this.secretKey});
}
