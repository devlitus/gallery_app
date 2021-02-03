import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gallery_app/services/product_service.dart';
import 'package:meta/meta.dart';

import 'package:gallery_app/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    switch (event.runtimeType) {
      case OngetProduct:
        yield* _getProduct(event);
        break;
      case OnAddImageAlbum:
        yield* _addImageAlbum(event);
        break;
      case OnChangeTitle:
        yield* _changeTitle(event);
        break;
      default:
    }
  }

  Stream<ProductState> _getProduct(OngetProduct event) async* {
    yield state.copyWith(product: event.product);
  }

  Stream<ProductState> _addImageAlbum(OnAddImageAlbum event) async* {
    // final _productService = ProductService();
    state.product.imgUrl = event.fileImage.path;
    /* if (event.fileImage != null) {
      final image = await _productService.uploadImage(event.fileImage);
      state.product.imgUrl = image;
      print('urlPhoto: $image');
    } */
    yield state.copyWith(product: state.product);
  }

  Stream<ProductState> _changeTitle(OnChangeTitle event) async* {
    state.product.title = event.title;
    yield state.copyWith(product: state.product);
  }
}
