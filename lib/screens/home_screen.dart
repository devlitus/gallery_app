import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:gallery_app/widgets/CustomItemList_widget.dart';
import 'package:gallery_app/widgets/customItemGrid_widget.dart';
import 'package:provider/provider.dart';

import 'package:gallery_app/bloc/screen_bloc.dart';
import 'package:gallery_app/widgets/floating_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenBloc screenBloc = Provider.of<ScreenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: Container(
        child: (screenBloc.isGrid) ? _createGrid() : _createList(),
      ),
      floatingActionButton: CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _createGrid() {
    ProductBloc _productBloc = ProductBloc();
    _productBloc.loadingProduct();
    return StreamBuilder(
        stream: _productBloc.productStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            return Container(
              margin: EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0),
                itemBuilder: (context, index) {
                  return GridItem(product: product[index]);
                },
                itemCount: product.length,
              ),
            );
          }
          return Center(
            child: Image.asset('assets/bools.gif'),
          );
        });
  }

  Widget _createList() {
    ProductBloc _productBloc = ProductBloc();
    _productBloc.loadingProduct();
    return StreamBuilder(
        stream: _productBloc.productStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            return ListView.builder(
                itemCount: product.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      background: Container(color: Colors.red),
                      child: Container(
                        child: ListItem(product: product[index]),
                      ));
                });
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}



