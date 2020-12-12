import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';
// import 'package:gallery_app/preference/user.dart';
import 'package:provider/provider.dart';

import 'package:gallery_app/widgets/custom_grid.dart';
import 'package:gallery_app/widgets/custom_listView.dart';
import 'package:gallery_app/bloc/screen_bloc.dart';
import 'package:gallery_app/widgets/floating_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductBloc _productBloc = ProductBloc();
  @override
  void initState() {
    super.initState();
    setState(() {
      _productBloc.loadingProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenBloc _screenBloc = Provider.of<ScreenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: Container(
        child: layoutType(_screenBloc.isGrid),
      ),
      floatingActionButton: CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget layoutType(bool value) {
    return StreamBuilder(
        stream: _productBloc.productStream,
        builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            if (value) {
              return Grid(product: product);
            }
            return ViewList();
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
