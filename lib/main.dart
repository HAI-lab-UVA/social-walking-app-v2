import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_walking_2/ui/sw_color.dart';
import 'package:social_walking_2/router_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Social Walking',
      theme: ThemeData(
        scaffoldBackgroundColor: SWColor.white,
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
