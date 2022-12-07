import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
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
            children: [
              CardSwiperWidget(movies: moviesProvider.onDisplayMovies),
              const SizedBox(height: 10),
              MovieSliderWidget(
                  movies: moviesProvider.popularMovies,
                  title: "Populares!",
                  onNextPage: () => moviesProvider.getPopularMovies()),
            ],
          ),
        ));
  }
}
