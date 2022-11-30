import 'package:flutter/material.dart';
import 'package:peliculas/pages/pages.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MoviesProvider(), lazy: false)],
      child: const MyApp(),
    );
  }
}

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
