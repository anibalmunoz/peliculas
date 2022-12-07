import 'package:flutter/cupertino.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards(this.movieId, {super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMoviesCast(movieId),
        builder: (context, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 180,
              child: const Center(child: CupertinoActivityIndicator()),
            );
          }
          final cast = snapshot.data;
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast!.length,
              itemBuilder: (BuildContext context, int index) => _CastCard(cast[index]),
            ),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard(this.actor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:  FadeInImage(
              placeholder: const AssetImage("assets/no-image.jpg"),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            )),
        const SizedBox(height: 5),
        Text(
          actor.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
