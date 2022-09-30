import 'package:flutter/material.dart';
import 'package:movie_app/movie.service.dart';
import 'package:movie_app/text.widget.dart';

import 'moviecard.widget.dart';
import 'moviedetails.screen.dart';

class DemoScreen extends StatelessWidget {
  final String searchQuery;
  const DemoScreen({Key? key, this.searchQuery = ""}) : super(key: key);

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
        future: MovieService().getSearchMovie(searchQuery: searchQuery),
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
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } catch (e) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
