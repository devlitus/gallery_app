import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';

import 'customItemList_widget.dart';

class ViewList extends StatefulWidget {
  @override
  _ViewListState createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
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
                    onDismissed: (direction) {
                      setState(() {
                        _productBloc.deleteProduct(product[index]);
                        _productBloc.loadingProduct();
                      });
                    });
              },
              separatorBuilder: (context, int index) => const Divider(),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
