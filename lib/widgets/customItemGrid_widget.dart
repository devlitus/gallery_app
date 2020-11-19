import 'package:flutter/material.dart';
import 'package:gallery_app/models/product_model.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(product.title),
        ),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(product.imgUrl)),
    );
  }
}