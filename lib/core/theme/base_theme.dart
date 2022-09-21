import 'package:google_fonts/google_fonts.dart';

import '../../app.dart';
import '../core.dart';

part 'theme_value.dart';

/// getters for get theme of restaurant application
/// used at [RestaurantApp]
ThemeData get darkTheme {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkColor,
    ),
    primaryColor: darkColor,
    primarySwatch: const MaterialColor(
      primaryColorHex,
      {
        50: primaryColor,
        100: primaryColor,
        200: primaryColor,
        300: primaryColor,
        400: primaryColor,
        500: primaryColor,
        600: primaryColor,
        700: primaryColor,
        800: primaryColor,
        900: primaryColor,
      },
    ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryColor,
      unselectedLabelColor: lightColor.withOpacity(0.5),
    ),
    textTheme: _textTheme.apply(
      fontFamily: "Poppins",
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    iconTheme: const IconThemeData(size: 15, color: primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(const Size(50, 30)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade900,
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(
          // color: darkColor,
          ),
    ),
  );
}

/// getters for get theme of restaurant application
/// used at [RestaurantApp]
ThemeData get lightTheme {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    primarySwatch: const MaterialColor(
      primaryColorHex,
      {
        50: primaryColor,
        100: primaryColor,
        200: primaryColor,
        300: primaryColor,
        400: primaryColor,
        500: primaryColor,
        600: primaryColor,
        700: primaryColor,
        800: primaryColor,
        900: primaryColor,
      },
    ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryColor,
      unselectedLabelColor: darkColor.withOpacity(0.5),
    ),
    textTheme: _textTheme.apply(
      fontFamily: "Poppins",
      bodyColor: darkColor,
      displayColor: darkColor,
    ),
    iconTheme: const IconThemeData(size: 15, color: primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: MaterialStateProperty.all(const Size(50, 30)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightColor,
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        color: darkColor.withOpacity(0.5),
      ),
    ),
  );
}

/// getters for get my text theme
TextTheme get _textTheme {
  return TextTheme(
    headline1: GoogleFonts.poppins(
      fontSize: 93,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 58,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 46,
      fontWeight: FontWeight.w400,
    ),
    headline4: GoogleFonts.poppins(
      fontSize: 33,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
    ),
  );
}
