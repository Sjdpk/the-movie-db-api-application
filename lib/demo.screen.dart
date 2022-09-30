import 'package:flutter/material.dart';
import 'package:movie_app/movie.service.dart';
import 'package:provider/provider.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MovieService>().getPopularMovies();
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<MovieService>(
        builder: (context, movieCtr, child) {
          return ListView.builder(
            itemCount: movieCtr.movieList.length,
            itemBuilder: (context, index) {
              final movieList = movieCtr.movieList[index];
              return Text(" $index ${movieList.adult}");
            },
          );
        },
      ),
    );
  }
}
