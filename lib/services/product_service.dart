import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:http/http.dart' as http;

import 'package:gallery_app/models/product_model.dart';

class ProductService {
  final _url = "https://flutter-varios-76cb4.firebaseio.com";
  final _cloudinary =
      Cloudinary('119358423775835', 'A3XEnIkTXAwVqIArCwHMU34iorE', 'djhxmjnb4');

  Future<List<ProductModel>> getProduct() async {
    final resp = await http.get('$_url/productos.json');
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = List();
    if (decodedData?.isEmpty ?? true) return [];
    decodedData.forEach((key, value) {
      final prodTemp = ProductModel.fromJson(value);
      prodTemp.id = key;
      products.add(prodTemp);
    });
    return products;
  }

  Future<bool> createProduct(ProductModel product) async {
    final resp = await http.post('$_url/productos.json',
        body: productModelToJson(product));
    final decodedDate = json.decode(resp.body);
    print(decodedDate);
    return true;
  }

  Future<String> uploadImage(File image) async {
    final resp = await _cloudinary.uploadFile(image.path,
        resourceType: CloudinaryResourceType.image);
    if (resp.isSuccessful ?? false) {
      // print('urlPhoto: ${resp.secureUrl}');
    }
    return resp.secureUrl;
  }

  Future<bool> editProduct(ProductModel product) async {
    final resp = await http.put('$_url/productos/${product.id}.json',
        body: productModelToJson(product));
    final decodedDate = json.decode(resp.body);
    return true;
  }

  Future<bool> deleteProduct(ProductModel product) async {
    await http.delete('$_url/productos/${product.id}.json');
    await _cloudinary.deleteFile(
        url: product.imgUrl, resourceType: CloudinaryResourceType.image);
    return true;
  }
}
