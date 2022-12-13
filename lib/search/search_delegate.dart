import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/pages/pages.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    return streamResult(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    return streamResult(context, query);
  }
}

Widget _emptyContainer() => const Center(child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130));

Widget streamResult(context, query) {
  final movieProvider = Provider.of<MoviesProvider>(context, listen: false);
  movieProvider.getSuggestionsByQuery(query);
  return StreamBuilder(
    stream: movieProvider.suggestionsStream,
    builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
      if (!snapshot.hasData) return _emptyContainer();
      final movies = snapshot.data;
      return ListView.builder(
        itemCount: movies!.length,
        itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
      );
    },
  );
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = "search-${movie.id}";

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage("assets/no-image.jpg"),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, DetailsPage.routeName, arguments: movie);
      },
    );
  }
}
