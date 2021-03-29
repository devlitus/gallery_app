part of 'product_bloc.dart';

@immutable
abstract class ProductState {
  final ProductModel product;
  final List<ProductModel> products;
  final List<ProductModel> deleteProduct;
  final String id;

  ProductState({
    this.product,
    this.products,
    this.deleteProduct,
    this.id,
  });
  copyWith({
    ProductModel product,
    List<ProductModel> products,
    List<ProductModel> deleteProduct,
    ProductModel id,
  });
}

class ProductInitial extends ProductState {
  final ProductModel product;
  final List<ProductModel> products;
  final List<ProductModel> deleteProduct;
  final String id;

  ProductInitial({
    this.product,
    this.products,
    List<ProductModel> deleteProduct,
    this.id,
  }) : deleteProduct = deleteProduct ?? [];

  @override
  copyWith({
    ProductModel product,
    List<ProductModel> products,
    List<ProductModel> deleteProduct,
    ProductModel id,
  }) =>
      ProductInitial(
        product: product ?? this.product,
        products: products ?? this.products,
        deleteProduct: deleteProduct ?? this.deleteProduct,
        id: id ?? this.id,
      );
}
