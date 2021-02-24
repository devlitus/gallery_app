part of 'product_bloc.dart';

@immutable
abstract class ProductState {
  final ProductModel product;
  final List<ProductModel> products;
  ProductState({this.product, this.products});
  copyWith({ProductModel product, List<ProductModel> products});
}

class ProductInitial extends ProductState {
  final ProductModel product;
  final List<ProductModel> products;
  ProductInitial({this.product, this.products});

  @override
  copyWith({ProductModel product, List<ProductModel> products}) =>
      ProductInitial(
          product: product ?? this.product,
          products: products ?? this.products);
}
