import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.title,
    this.imgUrl,
    this.favorite = false,
    this.check = false,
  });

  String id;
  String title;
  String imgUrl;
  bool favorite;
  bool check;

  ProductModel copyWith({
    String id,
    String title,
    String imgUrl,
    bool favorite,
    bool check,
  }) =>
      ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        imgUrl: imgUrl ?? this.imgUrl,
        favorite: favorite ?? this.favorite,
        check: check ?? this.check,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        imgUrl: json["imgUrl"],
        favorite: json["favorite"],
        check: json["check"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imgUrl": imgUrl,
        "favorite": favorite,
        "check": check,
      };
}
