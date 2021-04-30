import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gallery_app/services/product_service.dart';
import 'package:meta/meta.dart';

import 'package:gallery_app/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService = ProductService();
  ProductBloc() : super(ProductInitial());
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
    final products = await this._productService.getProduct();
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

  Stream<ProductState> _deleteItemProduct(OnDeleteItemProduct event) async* {
    final ProductModel productModel = ProductModel();
    productModel.check = event.productCheck.check;
    if(event.productCheck.check) {
      print (event.productCheck.check);
      state.deleteProduct.add(event.productCheck.id);
    } else {
      state.deleteProduct.remove(event.productCheck.id);
    }
    yield state.copyWith(product: productModel);
  }
}
