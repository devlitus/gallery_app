import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:gallery_app/services/product_service.dart';

class ProductBloc {
  final _productController = BehaviorSubject<List<ProductModel>>();
  final _isProductController = BehaviorSubject<bool>();
  final _productService = ProductService();
  Stream<List<ProductModel>> get productStream => _productController.stream;

  void loadingProduct() async {
    final products = await _productService.getProduct();
    _productController.sink.add(products);
  }
  void addProduct(ProductModel product) async {
    final _product = await _productService.createProduct(product);
    _isProductController.sink.add(_product);
  }
  void editProduct(ProductModel product) async {
    final _product = await _productService.editProduct(product);
    _isProductController.sink.add(_product);
  }
  Future<String> uploadImage(File fileImage) async {
    final image = await _productService.uploadImage(fileImage);
    return image;
  }
  void deleteProduct(ProductModel product) async {
    final resp = await _productService.deleteProduct(product);
    print('resp: $resp');
  }
  dispose() {
    _productController?.close();
    _isProductController?.close();
  }
}
