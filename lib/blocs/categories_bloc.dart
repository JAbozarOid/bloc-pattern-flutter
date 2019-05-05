import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_pattern/api/db_api.dart';
import 'package:flutter_bloc_pattern/models/category.dart';
import 'package:flutter_bloc_pattern/widgets/bloc_provider.dart';

class CategoriesBloc implements BlocBase {
  List<Category> _categories = List();

  StreamController<List<Category>> _categoriesController = StreamController<
      List<Category>>(); // this stream will be handle our stream
  Sink<List<Category>> get _inCategories => _categoriesController
      .sink; // it's used for this class so it should be private variable and it not call outside of the class
  Stream<List<Category>> get outCategories => _categoriesController
      .stream; // it's used out of the class and other classes so it should be public variable
  /// استریم مانند یه لوله میمونه که سینک در سمت چپ ان است و برای این داده را در داخل ان قرار دهیم و استریم در سمت راست این لوله است برای اینکه دادهایی که قرار گرفته در کلاس های دیگر استفاده کنیم

  CategoriesBloc() {
    getCategories();
  }

  // this method just handle get categories from dbApi class and push data to stream
  void getCategories() {
    DbApi dbApi = DbApi();
//    _categories = dbApi.getCategories(); // *** this method is just used for mockup ***
//    _inCategories.add(_categories);      // *** this method is just used for mockup ***

    // this method get real data from firestore
    dbApi.getCategories().listen((snapshot) {
      List<Category> tempCategories = List(); // initialize with empty list
      for (DocumentSnapshot doc in snapshot.documents) {
        Category category = Category.fromFirestore(doc.data);
        category.id = doc.documentID;
        tempCategories.add(category);
      }
      _categories.clear();
      _categories.addAll(tempCategories);
      _inCategories.add(_categories);
    });
  }

  @override
  void dispose() {
    _categoriesController.close();
  }
}
