import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
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
  ProductBloc _productBloc = ProductBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) _productModel = prodData;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.photo_album), onPressed: _album),
          IconButton(icon: Icon(Icons.add_a_photo), onPressed: _camera)
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _showImage(),
              _formProduct(),
            ],
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
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/bools.gif'),
            image: (_fileImage?.path == null)
                ? NetworkImage(_productModel.imgUrl)
                : FileImage(_fileImage),
          ));
    }
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FadeInImage(
        placeholder: AssetImage('assets/bools.gif'),
        image: (_fileImage?.path == null)
            ? AssetImage('assets/no-image.jpeg')
            : FileImage(_fileImage),
      ),
    );
  }

  Widget _formProduct() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Nombre de la imagen',
              ),
              initialValue: _productModel.title,
              onSaved: (value) => _productModel.title = value,
              validator: (value) =>
                  value.isEmpty ? 'No puede estar vacío' : null,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
              color: Colors.green,
              textColor: Color(0xffffffff),
              icon: Icon(Icons.send),
              label: Text('Guardar'),
              onPressed: _submit,
            )
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    if (_fileImage != null) {
      _productModel.imgUrl = await _productBloc.uploadImage(_fileImage);
    }
    (_productModel.id == null)
        ? _productBloc.addProduct(_productModel)
        : _productBloc.editProduct(_productModel);
    // FocusScope.of(context).requestFocus(new FocusNode());
    // _productBloc.loadingProduct();
    Navigator.of(context).pop();
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
      print('error: $e');
    }
    setState(() {});
  }
}
