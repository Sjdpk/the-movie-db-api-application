import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.model.dart';
import 'package:movie_app/screens/moviedetails.screen.dart';
import 'package:movie_app/controllers/search.controller.dart';
import 'package:movie_app/screens/search.screen.dart';
import 'package:movie_app/widgets/text.widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/movie.controller.dart';
import '../widgets/moviecard.widget.dart';

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
    final movieList =
        Provider.of<MovieServiceController>(context, listen: false);
    context.read<MovieServiceController>().getPopularMovies().then((_) {
      Future.delayed(Duration.zero, () {
        searchPvr.updateSearchList(movieList.movieList);
        searchPvr.namesList = movieList.movieList;
      });
    });

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 1,
        title: displayText("The Movie"),
      ),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (isTop) {
              log("scroll to  top");
            } else {
              if (movieList.currentPage < movieList.totalPage) {
                int currentPage = movieList.currentPage.toInt() + 1;
                // context
                //     .read<MovieService>()
                //     .getPopularMovies(currentPage: currentPage);
                context
                    .read<MovieServiceController>()
                    .getPopularMovies(currentPage: currentPage)
                    .then((_) {
                  Future.delayed(Duration.zero, () {
                    searchPvr.updateSearchList(movieList.movieList);
                    searchPvr.namesList = movieList.movieList;
                  });
                });
                log("scroll to  bottom ${movieList.currentPage} ${movieList.totalPage}");
              } else {
                log("no more data to load");
              }
            }
          }
          return true;
        },
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Consumer<SearchController>(
              builder: (context, searchCtr, child) {
                return searchPvr.namesList.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2.5,
                        ),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          color: Colors.white,
                        ),
                      )
                    : Column(
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
                                        searchCtr.updateSearchList(
                                            searchCtr.namesList);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        splashRadius: 0.1,
                                        onPressed: () {
                                          searchController.clear();
                                          searchCtr.updateSearchText("");
                                          searchCtr.updateSearchList(
                                              searchCtr.namesList);
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.black,
                                          size: searchController.text != ""
                                              ? 20
                                              : 0,
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
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  // get the list, if not found, return empty list.
                                  var recentSearchList =
                                      prefs.getStringList('recentsearchlist') ??
                                          [];
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MovieSearch(
                                          autoSuggestionList: recentSearchList),
                                    ),
                                  );
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
                                        moviename:
                                            searchCtr.searchList[index].title,
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
      ),
    );
  }
}
