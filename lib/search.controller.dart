import 'package:flutter/material.dart';

class SearchController with ChangeNotifier {
  String searchText = '';
  updateSearchText(value) {
    searchText = value;
    notifyListeners();
  }
}
