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
            title: Container(
              child: Text(product.title),
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

  Future _delete(BuildContext context, ProductModel product) {
    ProductBloc productBloc = ProductBloc();
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )),
        context: context,
        builder: (context) {
          return Container(
            height: 130.0,
            child: Column(
              children: [
                Text(
                  'Seguro que quieres eliminarlo',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RawMaterialButton(
                        fillColor: Colors.green,
                        child: Text('Aceptar'),
                        onPressed: () {
                          productBloc.deleteProduct(product);
                          Navigator.pushNamed(context, 'home');
                        },
                      ),
                      RawMaterialButton(
                        fillColor: Colors.red,
                        child: Text('Cancelar'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
