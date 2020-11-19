import 'package:flutter/material.dart';

class ScreenBloc with ChangeNotifier {
  bool _isGrid = true;

  get isGrid => _isGrid;

  set isGrid(grid) {
    _isGrid = grid;
    notifyListeners();
  }
}
