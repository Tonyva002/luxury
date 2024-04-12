
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.red;
  static const Color secundary = Colors.white;
  static const Color gris = Colors.grey;

  // Light Theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(

    // Color primario
    primaryColor: Colors.indigo,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
      titleTextStyle:
        TextStyle(
          color: secundary,
          fontSize: 25
        )
    ),


  //ElevatedButtons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: secundary,
        shape: const StadiumBorder(),
        shadowColor: secundary,
        backgroundColor: primary

      ),
     /* style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Color del botón
      ),*/
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