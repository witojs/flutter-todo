import 'package:flutter/material.dart';


ThemeData primaryTheme = ThemeData(

  //seed color
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.orange,
  ),

  //scaffold color
  scaffoldBackgroundColor: Colors.orange[300],

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
  
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,      
    )
  ),

);