import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:movie_app/models/movie.model.dart';

import '../services/movie.service.dart';

enum DataLoadingSate {
  initial,
  loading,
  sucess,
  error,
}

class MovieServiceController with ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  num _currentPage = 1;
  num get currentPage => _currentPage;

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
    final responseBody =
        await MovieService.getPopularMoviesList(currentPage: currentPage);
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

  // get search movies
  Future getSearchMovie(
      {required String searchQuery, int currentPage = 1}) async {
    List<MovieResultsModel> searchMovieListModelData = [];
    final responseData = await MovieService.getSearchMoviesList(
        searchQuery: searchQuery, currentPage: currentPage);
    final movieList = json.decode(responseData);
    for (var element in movieList['results']) {
      searchMovieListModelData.add(MovieResultsModel.fromJson(element));
    }

    _recentSearchList = searchMovieListModelData;
    return _recentSearchList;
  }
}
