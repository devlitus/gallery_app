part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class OnGetProduct extends ProductEvent {
  final ProductModel product;

  OnGetProduct({this.product});
}

class OnGetListProducts extends ProductEvent {}

class OnAddImageAlbum extends ProductEvent {
  final File fileImage;

  OnAddImageAlbum({this.fileImage});
}

class OnDeleteItemProduct extends ProductEvent {
  final ProductModel product;

  OnDeleteItemProduct({this.product});
}

class OnIsChecked extends ProductEvent {
  final ProductModel productCheck;

  OnIsChecked({this.productCheck});
}
