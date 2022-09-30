import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.model.dart';
import 'package:movie_app/widgets/text.widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieResultsModel movieResultsModel;
  const MovieDetailsScreen({Key? key, required this.movieResultsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: displayText(
          movieResultsModel.title.toString(),
          fontSize: 18,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Hero(
            tag: movieResultsModel.id.toString(),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500/${movieResultsModel.backdropPath}",
            ),
          ),
          displayText(
            movieResultsModel.title.toString(),
            fontWeight: FontWeight.bold,
            fontSize: 18,
            topPadding: 10,
            bottomPadding: 10,
          ),
          Text(
            movieResultsModel.overview.toString(),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              displayText("Release Date : "),
              displayText(movieResultsModel.releaseDate.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              displayText("Rating : "),
              displayText(movieResultsModel.voteAverage.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              displayText("Vote : "),
              displayText(movieResultsModel.voteCount.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
