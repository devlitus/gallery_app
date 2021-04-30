import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/bloc/product/product_bloc.dart';
import 'package:gallery_app/models/product_model.dart';
import 'package:gallery_app/widgets/custom_grid.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(OnGetListProducts());
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        actions: [
          _delete(context),
        ],
      ),
      body: CustomGrid(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final ProductModel product = ProductModel();
          BlocProvider.of<ProductBloc>(context)
              .add(OnGetProduct(product: product));
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }

  Widget _delete(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.deleteProduct.isNotEmpty) {
          return IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDialog(context),
          );
        }
        return Container();
      },
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Imagen !!!'),
          content: Text('¿Seguro que quieres eliminarlo estas imagenes?'),
          actions: [
            Row(
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('SI')),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('NO')),
              ],
            )
          ],
        );
      }
    );
  }
}

/* BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        // state.product?.check;
      },
      builder: (context, state) {
        if (state.product?.check ?? false) {
          return IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          );
        }
        return Container();
      },
    ); */
