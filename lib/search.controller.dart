import 'package:flutter/material.dart';
import 'package:movie_app/movie.model.dart';

class SearchController with ChangeNotifier {
  String searchText = '';
  List<MovieResultsModel> namesList = [];
  List<MovieResultsModel> searchList = [];
  updateSearchText(value) {
    searchText = value;
    notifyListeners();
  }

  updateSearchList(List<MovieResultsModel> names) {
    searchList = names;
    notifyListeners();
  }
}
