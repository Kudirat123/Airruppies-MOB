import 'package:flutter/material.dart';

class ThemesManager with ChangeNotifier {
  bool lightMode = true;
  ThemeData themeData() {
    return ThemeData(
        brightness: lightMode ? Brightness.light : Brightness.dark,
        scaffoldBackgroundColor: lightMode ? Colors.white : Colors.black ,
        
        
        
        
        
        
        
        
        
        
        
        );
  }
}
