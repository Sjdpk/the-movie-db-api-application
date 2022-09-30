import 'dart:convert';
import 'dart:developer';
import '../congig/.env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie.model.dart';

const baseurl = "https://api.themoviedb.org/3";
const apiKey = APIKEY;

enum DataLoadingSate {
  initial,
  loading,
  sucess,
  error,
}

class MovieService with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  num _currentPage = 1;
  num get currentPage => _currentPage;
  set setCurretnPage(int currentPage) => _currentPage;

  num _totalPage = 1;
  num get totalPage => _totalPage;

  List<MovieResultsModel> _movieList = [];
  List<MovieResultsModel> get movieList => _movieList;
  set movieListSet(List<MovieResultsModel> movieList) => _movieList = [];

  // recent searches
  List<MovieResultsModel> _recentSearchList = [];
  List<MovieResultsModel> get recentSearchList => _recentSearchList;
  set searchListSet(List<MovieResultsModel> movieList) =>
      _recentSearchList = [];
  // @desc get popular movie
  Future getPopularMovies({int currentPage = 1}) async {
    List<MovieResultsModel> movieListModelData = [];
    final responseBody = await getPopularMoviesList(currentPage: currentPage);
    final movieList = json.decode(responseBody);
    notifyListeners();

    for (var element in movieList['results']) {
      movieListModelData.add(MovieResultsModel.fromJson(element));
    }
    _currentPage = movieList['page'];
    _totalPage = movieList['total_pages'];
    _movieList = _movieList.toSet().toList();
    notifyListeners();
    _movieList = [..._movieList, ...movieListModelData.toSet().toList()];

    notifyListeners();
  }

  getPopularMoviesList({int currentPage = 1}) async {
    try {
      final popularMovieUrl =
          "/movie/popular?api_key=$apiKey&language=en-US&page=$currentPage";
      final finalUrl = baseurl + popularMovieUrl;
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
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
