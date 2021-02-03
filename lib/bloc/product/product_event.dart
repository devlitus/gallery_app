part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class OngetProduct extends ProductEvent {
  final ProductModel product;

  OngetProduct({this.product});
}

class OnAddImageAlbum extends ProductEvent {
  final File fileImage;

  OnAddImageAlbum({this.fileImage});
}

class OnChangeTitle extends ProductEvent {
  final String title;

  OnChangeTitle(this.title);
}
