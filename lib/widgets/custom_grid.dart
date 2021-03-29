import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallery_app/bloc/product/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final products = state.products;
        if (products != null) {
          return Container(
            margin: EdgeInsets.all(15.0),
            child: LiquidPullToRefresh(
              height: 60.0,
              showChildOpacityTransition: false,
              onRefresh: () => _handleRefresh(context),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, int index) {
                  return GridItem(product: products[index]);
                },
                itemCount: products.length,
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> _handleRefresh(BuildContext context) async {
    return context.read<ProductBloc>().add(OnGetListProducts());
  }
}

class GridItem extends StatelessWidget {
  final ProductModel product;
  const GridItem({@required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          GridTile(
            footer: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              clipBehavior: Clip.antiAlias,
              child: GridTileBar(
                backgroundColor: Colors.black45,
                title: Container(
                  child: Text(product.title),
                ),
              ),
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                product.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          (product.check ?? false) ? _checked() : Container(),
        ],
      ),
      onTap: () {
        BlocProvider.of<ProductBloc>(context)
            .add(OnGetProduct(product: product));
        Navigator.pushNamed(context, 'product');
      },
      onLongPress: () => _checkered(context),
    );
  }

  _checkered(BuildContext context) async {
    product.check = true;
    print('custom ${product.check}');
    context.read<ProductBloc>().add(OnDeleteItemProduct(product));
  }

  Container _checked() {
    return Container(
      width: 25.0,
      height: 25.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue[400]),
          shape: BoxShape.circle),
      child: Icon(
        Icons.check,
        color: Colors.blue[800],
      ),
    );
  }
}
