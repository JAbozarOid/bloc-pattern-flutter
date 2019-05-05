import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/blocs/categories_bloc.dart';
import 'package:flutter_bloc_pattern/blocs/products_bloc.dart';
import 'package:flutter_bloc_pattern/models/category.dart';
import 'package:flutter_bloc_pattern/pages/selected_category_page.dart';
import 'package:flutter_bloc_pattern/widgets/bloc_provider.dart';
import 'package:flutter_bloc_pattern/widgets/cart_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce'),
        actions: <Widget>[
          CartButton(),
        ],
      ),
      body: StreamBuilder<List<Category>>(
        stream: _categoriesBloc.outCategories,
        builder: (context, categories) {
          if (categories.hasData) {
            return ListView.builder(
                itemCount: categories.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = categories.data[index];
                  return ListTile(
                    onTap: () => navigateToSelectedCategory(context,category),
                    title: Text(
                      category.name,
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                });
          }
          return SizedBox();
        },
      ),
    );
  }

  void navigateToSelectedCategory(BuildContext context, Category category) {
     Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BlocProvider<ProductsBloc>(
                              child: SelectedCategoryPage(),
                              bloc: ProductsBloc(category))));
  }

// widgets are components that we use multiple time we don't actually rewrite them
// we have two types of widgets :
// 1- widgets that depends on the state of the project wich called "Containers" => instead of getting data directly and use in body get it from containers
// 2- widgets that depends not on the state of the projects
}
