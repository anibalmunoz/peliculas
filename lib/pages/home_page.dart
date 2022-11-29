import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Peliculas en cines"),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [CardSwiperWidget(), MovieSliderWidget()],
          ),
        ));
  }
}
