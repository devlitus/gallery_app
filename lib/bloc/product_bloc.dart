import 'package:rxdart/rxdart.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:gallery_app/services/product_service.dart';

class ProductBloc {
  final _productController = BehaviorSubject<List<ProductModel>>();
  final _productService = ProductService();
  Stream<List<ProductModel>> get productStream => _productController.stream;

  void loadingProduct() async {
    final products = await _productService.getProduct();
    _productController.sink.add(products);
  }

  dispose() {
    _productController?.close();
  }
}
