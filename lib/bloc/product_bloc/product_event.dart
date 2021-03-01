part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class OngetProduct extends ProductEvent {
  final ProductModel product;

  OngetProduct({this.product});
}

class OnGetListProducts extends ProductEvent {}

class OnAddImageAlbum extends ProductEvent {
  final File fileImage;

  OnAddImageAlbum({this.fileImage});
}

class OnDeleteItemProduct extends ProductEvent {
  final ProductModel productCheck;
  OnDeleteItemProduct(this.productCheck);
}

class OnIsCheked extends ProductEvent {
  final bool checked;

  OnIsCheked(this.checked);
}
