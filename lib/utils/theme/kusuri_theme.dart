import 'package:flutter/material.dart';

class KusuriTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF3F4F6),
    primaryColor: const Color(0xFF81C784),
    hintColor: const Color(0xFF757575),
    splashColor: const Color(0xFFB2DFDB),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF81C784),
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ListTile defaults
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xFFE8F5E9),
      textColor: Color(0xFF2E7D32),
      iconColor: Color(0xFF2E7D32),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Text
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF2E7D32), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF757575), fontSize: 14),
      titleMedium: TextStyle(color: Color(0xFF2E7D32), fontSize: 18, fontWeight: FontWeight.bold),
    ),

    // Icons
    iconTheme: const IconThemeData(color: Color(0xFF2E7D32)),

    // Elevated Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF81C784),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF81C784), // soft green
      foregroundColor: Colors.white,      //
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFE8F5E9), // unselected mint
      selectedColor: const Color(0xFF81C784),   // selected green
      disabledColor: const Color(0xFFF3F4F6),   // gray
      secondarySelectedColor: const Color(0xFF81C784),
      labelStyle: const TextStyle(
        color: Color(0xFF2E7D32),               // unselected text
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: const TextStyle(
        color: Colors.white,                   // selected text
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide.none,
      ),
      elevation: 0,
      pressElevation: 2,
      selectedShadowColor: Colors.black12,
      showCheckmark: false,
    ),


    // Input fields (e.g. medicine name, dosage)
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFFFFFFF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Color(0xFF757575)),
    ),
  );
}
