import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie.model.dart';

const baseurl = "https://api.themoviedb.org/3";
const apiKey = "369e5acb198bc1ec9e58a6a4d9582ecd";

class MovieService with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<MovieResultsModel> _movieList = [];
  List<MovieResultsModel> get movieList => _movieList;
  set movieListSet(List<MovieResultsModel> movieList) => _movieList = [];
  // @desc get popular movie
  Future getPopularMovies() async {
    List<MovieResultsModel> movieListModelData = [];
    try {
      const popularMovieUrl =
          "/movie/popular?api_key=$apiKey&language=en-US&page=1";
      final response = await http.get(Uri.parse(baseurl + popularMovieUrl));
      if (response.statusCode == 200) {
        final movieList = json.decode(response.body);
        notifyListeners();

        for (var element in movieList['results']) {
          // MovieResultsModel movieResultsModel =
          //     MovieResultsModel.fromJson(element);
          // print(movieResultsModel.adult);
          movieListModelData.add(MovieResultsModel.fromJson(element));
        }

        // log(movieList['page'].toString());
        // log(movieList['total_pages'].toString());
        // log(movieList['total_results'].toString());

        // movieList.forEach(
        //   (element) {
        //     log(element.toString());
        //     // if (element['results'].toString() != {}.toString()) {
        //     //   movieListModelData.add(
        //     //     MovieModel.fromJson(element),
        //     //   );
        //     // }
        //   },
        // );
        // MovieResultsModel movieResultsModel =
        //     MovieResultsModel.fromJson(result);
        _movieList = movieListModelData;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

// @desc search movies
  static Future searchMovie({String query = ''}) async {
    try {
      final searchMovieUrl =
          "/search/movie?api_key=$apiKey&language=en-US&query=$query&page=1&include_adult=false";
    } catch (e) {
      rethrow;
    }
  }
}
