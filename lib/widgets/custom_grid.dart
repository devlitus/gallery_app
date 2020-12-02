import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';

import 'customItemGrid_widget.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  ProductBloc _productBloc = ProductBloc();

  @override
  void initState() {
    super.initState();
    _productBloc.loadingProduct();
  }

  @override
  Widget build(BuildContext context) {
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
}