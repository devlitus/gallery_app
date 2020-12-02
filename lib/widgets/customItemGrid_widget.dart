import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GridTile(
        footer: Material(
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
            backgroundColor: Colors.black45,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0),
                ),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _delete(product))
              ],
            ),
          ),
        ),
        child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(product.imgUrl, fit: BoxFit.cover),
        ),
      ),
      onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
    );
  }

  void _delete(ProductModel product) {
    ProductBloc productBloc = ProductBloc();
    productBloc.deleteProduct(product);
  }
}
