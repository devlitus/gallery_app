import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  File _fileImage;
  ImagePicker _picker = ImagePicker();
  ProductModel _productModel = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.photo_album), onPressed: _album),
          IconButton(icon: Icon(Icons.add_a_photo), onPressed: _camera)
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [_showImage(), _formProduct()],
          ),
        ),
      ),
    );
  }

  Widget _showImage() {
    if (_productModel.imgUrl != null) {
      return ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage.assetNetwork(
            width: 300,
            height: 300,
            placeholder: 'assets/bools.gif',
            image: _productModel.imgUrl,
          ),
        );
    }
    return ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          height: 300,
          placeholder: AssetImage('assets/bools.gif'),
          image: (_fileImage?.path == null)
              ? AssetImage('assets/no-image.jpeg')
              : FileImage(_fileImage),
        ),
      );
  }

  Widget _formProduct() {
    return Container();
  }
  void _album() {
    _processingImage(ImageSource.gallery);
  }

  void _camera() {
    _processingImage(ImageSource.camera);
  }

  _processingImage(ImageSource origin) async {
    try {
      final photo = await _picker.getImage(source: origin);
      _fileImage = File(photo?.path);
      if (_fileImage.path == null) _productModel.imgUrl = null;
    } catch (e) {
      print('error $e');
    }
    setState(() {});
  }
}
