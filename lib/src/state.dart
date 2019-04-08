import 'package:awesome_theme/src/theme.dart';

class ThemeState {
  ThemeOption theme = ThemeOption();

  getTag(String tag, dynamic or) {
    return theme.tags[tag];
  }

  ThemeState({getTag, this.theme});
}
