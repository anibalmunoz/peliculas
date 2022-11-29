import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);
  static const routeName = "details";

  @override
  Widget build(BuildContext context) {
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? "no-movie";

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const _CustomAppbar(),
        SliverList(
          delegate: SliverChildListDelegate([
            const _PosterAndTittle(),
            const _Overview(),
            const _Overview(),
            const _Overview(),
            const CastingCards()
          ]),
        )
      ],
    ));
  }
}

class _CustomAppbar extends StatelessWidget {
  const _CustomAppbar();

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
          padding: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: const Text("movie.tittle", style: TextStyle(fontSize: 16)),
        ),
        background: const FadeInImage(
            placeholder: AssetImage("assets/loading.gif"),
            image: NetworkImage("https://via.placeholder.com/500x300"),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAndTittle extends StatelessWidget {
  const _PosterAndTittle();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            placeholder: AssetImage("assets/no-image.jpg"),
            image: NetworkImage("https://via.placeholder.com/200x300"),
            height: 150,
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("moovie.tittle", style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
            Text("moovie.originalTittle", style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1),
            Row(
              children: [
                const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                const SizedBox(width: 5),
                Text("movie.voteAverage", style: textTheme.caption),
              ],
            )
          ],
        )
      ]),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        "Occaecat dolore dolor ad mollit dolore id dolor amet fugiat aliquip. Qui mollit qui ea ut labore et ullamco amet aliquip commodo excepteur officia sunt. Consectetur proident magna fugiat esse incididunt",
        textAlign: TextAlign.justify,
        style: textTheme.subtitle1,
      ),
    );
  }
}
