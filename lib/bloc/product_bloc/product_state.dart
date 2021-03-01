part of 'product_bloc.dart';

@immutable
abstract class ProductState {
  final ProductModel product;
  final List<ProductModel> products;
  final String id;

  ProductState({
    this.product,
    this.products,
    this.id,
  });
  copyWith({
    ProductModel product,
    List<ProductModel> products,
    ProductModel id,
  });
}

class ProductInitial extends ProductState {
  final ProductModel product;
  final List<ProductModel> products;
  final String id;

  ProductInitial({
    this.product,
    this.products,
    this.id,
  });

  @override
  copyWith({
    ProductModel product,
    List<ProductModel> products,
    ProductModel id,
  }) =>
      ProductInitial(
        product: product ?? this.product,
        products: products ?? this.products,
        id: id ?? this.id,
      );
}
