part of 'product_bloc.dart';

@immutable
abstract class ProductState {
  final ProductModel product;

  ProductState({this.product});
  copyWith({ProductModel product});
}

class ProductInitial extends ProductState {
  final ProductModel product;
  ProductInitial({this.product});
  @override
  copyWith({ProductModel product}) =>
      ProductInitial(product: product ?? this.product);
}
