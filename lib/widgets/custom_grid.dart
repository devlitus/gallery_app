import 'package:flutter/material.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:gallery_app/widgets/customItemGrid_widget.dart';

class Grid extends StatelessWidget {
  final List<ProductModel> product;
  Grid({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, int index) {
            return GridItem(product: product[index]);
          },
          itemCount: product.length,
          ),

    );
  }
}

/* StreamBuilder(
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
        }); */
