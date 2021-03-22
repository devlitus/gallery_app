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
        if (state.product?.check ?? false) {
          return IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          );
        }
        return Container();
      },
    );
  }
}

/*final delete = context.read<ProductBloc>().state;

print('delete: ${delete.product?.check}');

if (delete.product?.check ?? false) {
return IconButton(
icon: Icon(Icons.delete),
onPressed: () {},
);
}
return Container();*/
