import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/blocs/cart_bloc.dart';
import 'package:flutter_bloc_pattern/blocs/categories_bloc.dart';
import 'package:flutter_bloc_pattern/pages/home_page.dart';
import 'package:flutter_bloc_pattern/widgets/bloc_provider.dart';

void main() => runApp(BlocProvider<CartBloc>(child: MyApp(), bloc: CartBloc()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: BlocProvider<CategoriesBloc>(
        bloc: CategoriesBloc(),
        child: HomePage(),
      ),
    );
  }
}
