import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:gallery_app/models/product_model.dart';

class ProductService {
  final _url = "https://flutter-varios-76cb4.firebaseio.com/productos.json";
  Future<List<ProductModel>> getProduct() async {
    final resp = await http.get(_url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = List();
    decodedData.forEach((key, value) {
      final prodTemp = ProductModel.fromJson(value);
      prodTemp.id = key;
      products.add(prodTemp);
    });
    return products;
  }
}