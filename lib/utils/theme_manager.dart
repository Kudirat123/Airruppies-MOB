import 'package:airruppies/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window .platformBrightness;
      return brightness == Brightness.light;
    } else {
      return themeMode == ThemeMode.light;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black
        

      ),
      
      primaryColor: Colors.black,
     
      colorScheme: const ColorScheme.dark(),
      //appBarTheme: 
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: TextTheme(
          displaySmall: GoogleFonts.manrope(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          bodySmall: GoogleFonts.manrope(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),


          // bodyText1: GoogleFonts.manrope(
          //   color: Colors.white,
          //   fontWeight: FontWeight.w300,
          //   fontSize: 17,
          // ),
          // bodyText2: GoogleFonts.manrope(
          //   color: Colors.white,
          //   fontWeight: FontWeight.w300,
          //   fontSize: 17,
          // )
          
          )
          );

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.light(),
       appBarTheme: AppBarTheme(
        backgroundColor: themes().primaryColor
        

      ),
      iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
      textTheme: TextTheme(
        displaySmall: GoogleFonts.manrope(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
          bodySmall: GoogleFonts.manrope(
            color: themes().whiteColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          // headline1,: GoogleFonts.manrope(
          //   color: themes().blackColor,
          //   fontWeight: FontWeight.w300,
          //   fontSize: 17,
          // ),
          // bodyText2: GoogleFonts.manrope(
          //   color: themes().blackColor,
          //   fontWeight: FontWeight.w300,
          //   fontSize: 17,
          // )
      ), bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white));
}
