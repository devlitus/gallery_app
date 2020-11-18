import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final _formKey = GlobalKey<FormState>();

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
        child: FadeInImage.assetNetwork(
          height: 200,
          placeholder: 'assets/bools.gif',
          image: _productModel.imgUrl,
        ),
      );
    }
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10.0),
      child: FadeInImage(
        // height: 200,
        placeholder: AssetImage('assets/bools.gif'),
        image: (_fileImage?.path == null)
            ? AssetImage('assets/no-image.jpeg')
            : FileImage(_fileImage, scale: 4.0),
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
              padding: EdgeInsets.symmetric(horizontal: 20.0),
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

  void _submit() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    print(_productModel.title);
    // FocusScope.of(context).requestFocus(new FocusNode());
    // Navigator.of(context).pushNamed('home');
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
