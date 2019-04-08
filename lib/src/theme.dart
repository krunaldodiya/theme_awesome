import 'package:flutter/material.dart';

class ThemeOption {
  Map tags = Map();

  set({@required themeData}) {
    final List themes = themeData['project']['themes'];
    final defaultThemeId = themeData['project']['default_theme_id'];

    final defaultTheme = themes.where((theme) {
      return theme['id'] == defaultThemeId;
    }).first;

    return ThemeOption()..tags = update(defaultTheme['tags']);
  }

  update(tags) {
    Map updatedTags = Map();

    tags.forEach((tag) {
      updatedTags[tag['key']] = checkRuntimeType(tag['value'], tag['type']);
    });

    return updatedTags;
  }

  checkRuntimeType(value, runtimeType) {
    if (runtimeType == "MaterialColor") {
      return Color(int.parse(value));
    }

    if (runtimeType == "Double") {
      return double.parse(value);
    }

    if (runtimeType == "Integer") {
      return int.parse(value);
    }

    if (runtimeType == "String") {
      return value;
    }
  }
}
