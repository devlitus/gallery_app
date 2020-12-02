import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';

class ScreenBloc with ChangeNotifier {
  bool _isGrid = true;

  get isGrid => _isGrid;

  set isGrid(grid) {
    _isGrid = grid;
    notifyListeners();
  }
}
