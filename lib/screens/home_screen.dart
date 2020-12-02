import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:gallery_app/widgets/CustomItemList_widget.dart';
import 'package:gallery_app/widgets/customItemGrid_widget.dart';
import 'package:provider/provider.dart';

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
    _productBloc.loadingProduct();
  }
  @override
  Widget build(BuildContext context) {
    ScreenBloc _screenBloc = Provider.of<ScreenBloc>(context);
    _productBloc.loadingProduct();
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: Container(
        child: (_screenBloc.isGrid)
            ? _createGrid(_productBloc)
            : _createList(_productBloc),
      ),
      floatingActionButton: CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _createGrid(ProductBloc _productBloc) {
    return StreamBuilder(
        stream: _productBloc.productStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            if (product.length == 0)
              return Container(
                child: Center(
                  child: Text('No hay elementos'),
                ),
              );
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
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget _createList(ProductBloc _productBloc) {
    return StreamBuilder(
        stream: _productBloc.productStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            if (product.length == 0)
              return Container(
                child: Center(
                  child: Text('No hay elementos'),
                ),
              );
            return ListView.separated(
              padding: EdgeInsets.all(10.0),
              itemCount: product.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  background: Container(color: Colors.red),
                  child: Container(
                    child: ListItem(product: product[index]),
                  ),
                  onDismissed: (direction) =>
                      delete(direction, product[index], _productBloc),
                );
              },
              separatorBuilder: (context, int index) => const Divider(),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  delete(DismissDirection direction, ProductModel product,
      ProductBloc productBloc) {
    productBloc.deleteProduct(product);
  }
}
