
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;
  static const Color white = Colors.white;
  static const Color gris = Colors.grey;

  // Light Theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(

    // Color de fondo
    scaffoldBackgroundColor: Colors.grey[300],

    // Color primario
    primaryColor: Colors.indigo,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle:
        TextStyle(
          color: white,
          fontSize: 25
        )
    ),


  //ElevatedButtons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: white,
        shape: const StadiumBorder(),
        shadowColor: white,
        backgroundColor: primary

      ),
    ),

      // InputDecorationTheme
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: gris),
        borderRadius: BorderRadius.only( bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10))
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only( bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(10))

      )

  )

  );
}