import 'package:flutter/material.dart';
import 'package:movie_app/movie.model.dart';
import 'package:movie_app/moviedetails.screen.dart';
import 'package:movie_app/search.controller.dart';
import 'package:movie_app/search.screen.dart';
import 'package:movie_app/text.widget.dart';
import 'package:provider/provider.dart';
import 'movie.service.dart';
import 'moviecard.widget.dart';

class MoviesHomePage extends StatelessWidget {
  MoviesHomePage({super.key});
  final decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(7),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 2,
        spreadRadius: 2,
      )
    ],
  );
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchPvr = Provider.of<SearchController>(context, listen: false);
    context.read<MovieService>().getPopularMovies();
    final movieList = Provider.of<MovieService>(context, listen: false);

    Future.delayed(Duration.zero, () {
      searchPvr.updateSearchList(movieList.movieList);
      searchPvr.namesList = movieList.movieList;
    });

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 1,
        title: displayText("The Movie"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/test');
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Consumer<SearchController>(
            builder: (context, searchCtr, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 40,
                          decoration: decoration,
                          child: TextFormField(
                            controller: searchController,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              searchCtr.updateSearchText(value);
                              List<MovieResultsModel> newList = [];

                              for (var i = 0;
                                  i < searchCtr.namesList.length;
                                  i++) {
                                if (searchCtr.namesList[i].title!
                                    .toLowerCase()
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  newList.add(searchCtr.namesList[i]);
                                }
                              }
                              searchCtr.updateSearchList(newList);
                              if (value == "") {
                                searchCtr.updateSearchList(searchCtr.namesList);
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                splashRadius: 0.1,
                                onPressed: () {
                                  searchController.clear();
                                  searchCtr.updateSearchText("");
                                  searchCtr
                                      .updateSearchList(searchCtr.namesList);
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                  size: searchController.text != "" ? 20 : 0,
                                ),
                              ),
                              hintText: 'Search',
                              contentPadding: const EdgeInsets.only(
                                top: 7,
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.pushNamed(context, '/search');
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.all(7),
                          decoration: decoration,
                          child: const Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                  displayText(
                    searchCtr.searchText == ""
                        ? "Popular Movies"
                        : "Movie Searches",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    bottomPadding: 14,
                    topPadding: 14,
                  ),
                  searchCtr.searchList.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 192,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemCount: searchCtr.searchList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MovieDetailsScreen(
                                      movieResultsModel:
                                          searchCtr.searchList[index],
                                    ),
                                  ),
                                );
                              },
                              child: displaymovieCard(
                                image:
                                    "https://image.tmdb.org/t/p/w500/${searchCtr.searchList[index].backdropPath}",
                                moviename: searchCtr.searchList[index].title,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: displayText(
                            "No Movie Found 🧐 ",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            topPadding: 30,
                          ),
                        ),
                ],
              );
            },
          )),
    );
  }
}
