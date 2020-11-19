import 'package:flutter/material.dart';
import 'package:gallery_app/bloc/screen_bloc.dart';
import 'package:provider/provider.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenBloc screenBloc = Provider.of<ScreenBloc>(context);
    return FloatingActionButton.extended(
      isExtended: true,
      label: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, 'product'),
          ),
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () {
              screenBloc.isGrid = true;
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              screenBloc.isGrid = false;
            },
          )
        ],
      ),
      onPressed: () {},
    );
  }
}
