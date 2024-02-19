import 'package:flutter/material.dart';
import 'package:galaxy_planet/view/detail_page.dart';
import 'package:galaxy_planet/view/start_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/json_decode_provider.dart';
import 'controller/theme_provider.dart';
import 'view/home_page.dart';
late SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
          ThemeProvider()
            ..getTheme(),
        ),
        ChangeNotifierProvider(
          create: (context) => puzz_provider(),
        ),
      ],
      builder: (context, child) {
        return Consumer <ThemeProvider>(
            builder: (context,themeprovider, child) {
              return MaterialApp(

                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                routes: {
                  '/': (context) =>  start_page(),
                  'home_screen' :(context)=>Home_planet(),
                  'detail_page' :(context)=>DetailsPage(),
                },
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeprovider.thememode,
              );
            }
        );
      },
    );
  }
}
