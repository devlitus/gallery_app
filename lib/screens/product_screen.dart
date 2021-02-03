import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gallery_app/bloc/product/product_bloc.dart';
import 'package:gallery_app/services/product_service.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, 'home'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_album),
            onPressed: () => _album(context),
          ),
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => _camera(context),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imageProduct(),
              _dataProduct(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageProduct() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final product = state.product;
        if (product.imgUrl != null && product.imgUrl.contains('https')) {
          return Container(
            margin: EdgeInsets.all(15.0),
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                product.imgUrl,
                fit: BoxFit.cover,
                cacheHeight: 300,
                cacheWidth: 300,
              ),
            ),
          );
        }
        return Container(
            child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10.0),
          child: (product.imgUrl == null)
              ? Image.asset(
                  'assets/images/no-image.jpeg',
                  cacheHeight: 300,
                  cacheWidth: 300,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(product.imgUrl),
                  cacheHeight: 300,
                  cacheWidth: 300,
                  fit: BoxFit.cover,
                ),
        ));
      },
    );
  }

  Widget _dataProduct() {
    final _formKey = GlobalKey<FormState>();
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            final product = state.product;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Nombre de la imagen',
                    ),
                    initialValue: product.title,
                    onSaved: (value) => product.title = value,
                    validator: (value) =>
                        value.isEmpty ? 'No puede estar vacío' : null,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding:
                        EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                    color: Colors.green,
                    textColor: Color(0xffffffff),
                    icon: Icon(Icons.send),
                    label: Text('Guardar'),
                    onPressed: () => _submit(context, _formKey),
                  )
                ],
              ),
            );
          },
        ));
  }

  void _submit(BuildContext contex, GlobalKey<FormState> _formkey) async {
    final state = contex.read<ProductBloc>().state;
    final productService = ProductService();
    if (!_formkey.currentState.validate()) return;
    if (!state.product.imgUrl.contains('https')) {
      final image =
          await productService.uploadImage(File(state.product.imgUrl));
      state.product.imgUrl = image;
    }
    _formkey.currentState.save();
    if (state.product.id == null) productService.createProduct(state.product);
    print(state.product.title);
    print(state.product.imgUrl);
  }

  void _album(BuildContext context) {
    _processingImage(ImageSource.gallery, context);
  }

  void _camera(BuildContext context) {
    _processingImage(ImageSource.camera, context);
  }

  _processingImage(ImageSource origin, BuildContext context) async {
    final _picker = ImagePicker();
    try {
      final photo = await _picker.getImage(source: origin);
      BlocProvider.of<ProductBloc>(context)
          .add(OnAddImageAlbum(fileImage: File(photo.path)));
    } catch (e) {
      print('error: $e');
    }
  }
}
