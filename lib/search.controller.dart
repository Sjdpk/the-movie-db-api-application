import 'package:flutter/material.dart';

class SearchController with ChangeNotifier {
  String searchText = '';
  List<String> namesList = [];
  List<String> searchList = [];
  updateSearchText(value) {
    searchText = value;
    notifyListeners();
  }

  updateSearchList(List<String> names) {
    searchList = names;
    notifyListeners();
  }
}
