import 'package:flutter/material.dart';
import 'package:gallery_app/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
      },
      themeMode: ThemeMode.system,
    );
  }
}
