import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:gallery_app/widgets/floating_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  ProductBloc _productBloc = ProductBloc();
  _productBloc.loadingProduct();
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: _productBloc.productStream,
          builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){
            if (snapshot.hasData) {
              return Container();
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


