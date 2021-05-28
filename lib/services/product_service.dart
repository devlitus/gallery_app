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
    final url = Uri.parse('$_url/productos.json');
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductModel> products = [];
    if (decodedData?.isEmpty ?? true) return [];
    decodedData.forEach((key, value) {
      final prodTemp = ProductModel.fromJson(value);
      prodTemp.id = key;
      products.add(prodTemp);
    });
    return products;
  }

  Future<bool> createProduct(ProductModel product) async {
    final url = Uri.parse('$_url/productos.json');
    final resp = await http.post(url, body: productModelToJson(product));
    final decodedDate = json.decode(resp.body);
    print(decodedDate);
    return true;
  }

  Future<String> uploadImage(File image) async {
    final resp = await _cloudinary.uploadFile(
        filePath: image.path, resourceType: CloudinaryResourceType.image);
    if (resp.isSuccessful ?? false) {
      // print('urlPhoto: ${resp.secureUrl}');
    }
    return resp.secureUrl;
  }

  Future<bool> editProduct(ProductModel product) async {
    final url = Uri.parse('$_url/productos/${product.id}.json');
    final resp = await http.post(url, body: productModelToJson(product));
    final decodedDate = json.decode(resp.body);
    return true;
  }

  Future<bool> deleteProduct(ProductModel product) async {
    final url = Uri.parse('$_url/productos/${product.id}.json');
    final resp = await http.delete(url);

    // await _cloudinary.deleteFile(
    //     url: product.imgUrl, resourceType: CloudinaryResourceType.image);
    return true;
  }

  Future<bool> deletesImage(List<String> images) async {
    final response = await _cloudinary.deleteFiles(
      urls: images,
      resourceType: CloudinaryResourceType.image,
    );
    if (response.isSuccessful ?? false) {
      Map<String, dynamic> deleted = response.deleted;
      print(deleted);
      return true;
    }
    return false;
  }
}

