import 'package:flutter/material.dart';
import 'package:gallery_app/models/product_model.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (product.imgUrl == null)
                  ? Image.asset('assets/no-image.jpeg')
                  : ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/bools.gif',
                  image: product.imgUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  product.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
    );
  }
}
