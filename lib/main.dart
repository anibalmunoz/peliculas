import 'package:flutter/material.dart';
import 'package:peliculas/pages/pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {"home": (context) => const HomePage(), DetailsPage.routeName: (context) => const DetailsPage()},
      theme: ThemeData.light().copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo, centerTitle: true)),
    );
  }
}
