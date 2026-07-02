import 'package:flutter/material.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:social_walking_2/router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: SWColor.white.color,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.alexandria(
            textStyle: TextStyle(fontSize: 24.0),
          ),
          titleMedium: GoogleFonts.alexandria(
            textStyle: TextStyle(fontSize: 18.0),
          ),
          bodyMedium: GoogleFonts.alexandria(
            textStyle: TextStyle(fontSize: 16.0),
          ),
          bodySmall: GoogleFonts.alexandria(
            textStyle: TextStyle(fontSize: 14.0),
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
