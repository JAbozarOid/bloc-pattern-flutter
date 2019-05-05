import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_pattern/api/db_api.dart';
import 'package:flutter_bloc_pattern/models/category.dart';
import 'package:flutter_bloc_pattern/models/product.dart';
import 'package:flutter_bloc_pattern/widgets/bloc_provider.dart';

class ProductsBloc implements BlocBase{

  List<Product> _products = List();

  final _productsController = StreamController<List<Product>>(); // this stream will be handle our stream
  Sink<List<Product>> get _inProducts => _productsController.sink; // it's used for this class so it should be private variable and it not call outside of the class
  Stream<List<Product>> get outProducts => _productsController.stream; // it's used out of the class and other classes so it should be public variable
  /// استریم مانند یه لوله میمونه که سینک در سمت چپ ان است و برای این داده را در داخل ان قرار دهیم و استریم در سمت راست این لوله است برای اینکه دادهایی که قرار گرفته در کلاس های دیگر استفاده کنیم

  ProductsBloc(Category category){
    getProducts(category);
  }

  void getProducts(Category category){
    DbApi dbApi = DbApi();
//    _products = dbApi.getProducts(category); // *** this method is just used for mockup ***
//    _inProducts.add(_products);              // *** this method is just used for mockup ***

    // this method get real data from firestore
    dbApi.getProducts(category).listen((snapshot) {
      List<Product> tempProducts = List(); // initialize with empty list
      for (DocumentSnapshot doc in snapshot.documents) {
        Product product = Product.fromFirestore(doc.data);
        product.id = doc.documentID;
        tempProducts.add(product);
      }
      _products.clear();
      _products.addAll(tempProducts);
      _inProducts.add(_products);
    });
    
//    _productsController.add('this is an error');
  }


  @override
  void dispose() {
    _productsController.close();
  }


}