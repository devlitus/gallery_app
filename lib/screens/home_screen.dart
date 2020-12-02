import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:gallery_app/widgets/customItemList_widget.dart';
import 'package:gallery_app/widgets/customItemGrid_widget.dart';
import 'package:gallery_app/widgets/custom_grid.dart';
import 'package:gallery_app/widgets/custom_listView.dart';
import 'package:provider/provider.dart';

import 'package:gallery_app/bloc/screen_bloc.dart';
import 'package:gallery_app/widgets/floating_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenBloc _screenBloc = Provider.of<ScreenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: Container(
          child: (_screenBloc.isGrid)
              ? Grid()
              : ViewList()
      ),
      floatingActionButton: CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

