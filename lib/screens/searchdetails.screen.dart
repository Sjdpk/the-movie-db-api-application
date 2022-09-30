import 'package:flutter/material.dart';
import 'package:movie_app/controllers/movie.controller.dart';
import 'package:movie_app/widgets/text.widget.dart';

import '../widgets/moviecard.widget.dart';
import 'moviedetails.screen.dart';

class SearchDetailsScreen extends StatelessWidget {
  final String searchQuery;
  const SearchDetailsScreen({Key? key, this.searchQuery = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.read<MovieService>().getPopularMovies(searchQuery: searchQuery);
    // final searchList = Provider.of<MovieService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: displayText(searchQuery),
      ),
      body: FutureBuilder(
        future:
            MovieServiceController().getSearchMovie(searchQuery: searchQuery),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              final snapshotData = snapshot.data;
              // return Text(("data ${snapshotData[1].title}"));
              return GridView.builder(
                padding: const EdgeInsets.all(14),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 192,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: snapshotData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailsScreen(
                            movieResultsModel: snapshotData[index],
                          ),
                        ),
                      );
                    },
                    child: displaymovieCard(
                      image:
                          "https://image.tmdb.org/t/p/w500/${snapshotData[index].backdropPath}",
                      moviename: snapshotData[index].title,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                ),
              );
            }
          } catch (e) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
