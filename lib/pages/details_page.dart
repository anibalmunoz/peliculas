import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  static const routeName = "details";

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppbar(movie),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTittle(movie),
            _Overview(movie.overview),
            CastingCards(movie.id),
          ]),
        )
      ],
    ));
  }
}

class _CustomAppbar extends StatelessWidget {
  final Movie movie;
  const _CustomAppbar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(movie.title,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center),
        ),
        background: FadeInImage(
            placeholder: const AssetImage("assets/loading.gif"),
            image: NetworkImage(movie.fullBackdropPath),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAndTittle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTittle(this.movie);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Hero(
          tag: movie.heroId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage("assets/no-image.jpg"),
              image: NetworkImage(movie.fullPosterImg),
              height: 150,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title, style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2),
              Text(movie.originalTitle, style: textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(movie.voteAverage.toString(), style: textTheme.bodySmall),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _Overview extends StatelessWidget {
  final String descriptionText;
  const _Overview(this.descriptionText);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 45),
      child: Text(
        descriptionText,
        textAlign: TextAlign.justify,
        style: textTheme.titleMedium,
      ),
    );
  }
}
