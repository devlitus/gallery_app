// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.title,
    this.imgUrl,
    this.favorite,
  });

  String id;
  String title;
  String imgUrl;
  String favorite;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    imgUrl: json["imgUrl"],
    favorite: json["favorite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "imgUrl": imgUrl,
    "favorite": favorite,
  };
}
