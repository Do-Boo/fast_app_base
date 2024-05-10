import 'package:flutter/material.dart';

class SearchTextProvider with ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }
}

class ReservationAppBarLineProvider with ChangeNotifier {
  bool _reservationAppbarLine = true;

  bool get reservationAppbarLine => _reservationAppbarLine;

  void setReservationAppbarLine(bool bool) {
    _reservationAppbarLine = bool;
    notifyListeners();
  }
}

class SelectedDayProvider with ChangeNotifier {
  DateTime _selectedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;

  void setSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }
}

class SearchResultProvider with ChangeNotifier {
  Future<List<Map>>? _searchResult;

  Future<List<Map>>? get searchResult => _searchResult;

  void setSearchResult(Future<List<Map>>? value) {
    _searchResult = value;
    notifyListeners();
  }
}
