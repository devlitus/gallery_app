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
  final ProductService productService = ProductService();
  final List<ProductModel> itemChecked = [];
  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    switch (event.runtimeType) {
      case OnGetProduct:
        yield* _getProduct(event);
        break;
      case OnGetListProducts:
        yield* _getListProduct(event);
        break;
      case OnAddImageAlbum:
        yield* _addImageAlbum(event);
        break;
      case OnIsChecked:
        yield* _isChecked(event);
        break;
      case OnDeleteItemProduct:
        yield* _deleteItemProduct(event);
        break;
      default:
    }
  }

  Stream<ProductState> _getProduct(OnGetProduct event) async* {
    yield state.copyWith(product: event.product);
  }

  Stream<ProductState> _getListProduct(OnGetListProducts event) async* {
    final products = await this.productService.getProduct();
    yield state.copyWith(products: products);
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

  Stream<ProductState> _isChecked(OnIsChecked event) async* {
    print(event.productCheck.toJson());
    yield state.copyWith(product: event.productCheck);
  }

  Stream<ProductState> _deleteItemProduct(OnDeleteItemProduct event) async* {
    final bool check = event.product.check;
    if (check) {
      itemChecked.add(event.product);
    } else {
      itemChecked.remove(event.product);
    }
    yield state.copyWith(deleteProduct: itemChecked);
  }
}
