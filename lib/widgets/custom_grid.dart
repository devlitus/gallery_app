import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallery_app/bloc/product/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';
// import 'package:gallery_app/services/product_service.dart';

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
                  return GridItem(product: products[index], index: index);
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

class GridItem extends StatefulWidget {
  final ProductModel product;
  final int index;
  const GridItem({Key key, @required this.product, this.index})
      : super(key: key);

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
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
                  child: Text(widget.product.title),
                ),
              ),
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.product.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          (this.widget.product.check ?? false) ? _checked() : Container(),
        ],
      ),
      onTap: () {
        BlocProvider.of<ProductBloc>(context)
            .add(OngetProduct(product: widget.product));
        Navigator.pushNamed(context, 'product');
      },
      onLongPress: () => _checkered(context),
    );
  }

  _checkered(BuildContext context) async {
    setState(() {
      widget.product.check = true;
      context.read<ProductBloc>()..add(OnDeleteItemProduct(widget.product));
    });
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
