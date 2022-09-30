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

  // recent searches
  List<MovieResultsModel> _recentSearchList = [];
  List<MovieResultsModel> get recentSearchList => _recentSearchList;
  set searchListSet(List<MovieResultsModel> movieList) =>
      _recentSearchList = [];
  // @desc get popular movie
  Future getPopularMovies({String searchQuery = ""}) async {
    List<MovieResultsModel> movieListModelData = [];
    List<MovieResultsModel> searchMovieListModelData = [];
    try {
      const popularMovieUrl =
          "/movie/popular?api_key=$apiKey&language=en-US&page=1";
      final searchUrl =
          "/search/movie?api_key=$apiKey&language=en-US&query=$searchQuery&page=1&include_adult=false";
      final finalUrl =
          searchQuery == "" ? baseurl + popularMovieUrl : baseurl + searchUrl;
      final response = await http.get(Uri.parse(finalUrl));
      log(response.body.toString());
      if (response.statusCode == 200) {
        final movieList = json.decode(response.body);
        notifyListeners();

        for (var element in movieList['results']) {
          movieListModelData.add(MovieResultsModel.fromJson(element));
        }
        if (searchQuery != "") {
          _recentSearchList = searchMovieListModelData;
        } else {
          _movieList = movieListModelData;
        }

        notifyListeners();
      } else {
        _isLoading = true;
      }
    } catch (e) {
      _isLoading = true;
      rethrow;
    }
  }

  // get search movies
  Future getSearchMovie({required searchQuery}) async {
    try {
      final searchUrl =
          "/search/movie?api_key=$apiKey&language=en-US&query=$searchQuery&page=1&include_adult=false";
      final response = await http.get(Uri.parse(baseurl + searchUrl));
      if (response.statusCode == 200) {
        List<MovieResultsModel> searchMovieListModelData = [];

        final movieList = json.decode(response.body);
        for (var element in movieList['results']) {
          searchMovieListModelData.add(MovieResultsModel.fromJson(element));
        }
        return searchMovieListModelData;
      }
    } catch (e) {
      rethrow;
    }
  }
}
