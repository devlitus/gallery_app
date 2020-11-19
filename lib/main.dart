import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/screen_bloc.dart';

import 'package:gallery_app/screens/home_screen.dart';
import 'package:gallery_app/screens/product_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ScreenBloc()),
    ],
     child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
        'product': (context) => ProductScreen(),
      },
      themeMode: ThemeMode.system,
    );
  }
}
