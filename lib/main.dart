import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gallery_app/bloc/screen_bloc.dart';
import 'package:gallery_app/preference/user.dart';
import 'package:gallery_app/screens/home_screen.dart';
import 'package:gallery_app/screens/product_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenceUser();
  await prefs.initPref();
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
