import 'dart:async';

import 'package:flutter_bloc_pattern/models/cart.dart';
import 'package:flutter_bloc_pattern/models/product.dart';
import 'package:flutter_bloc_pattern/widgets/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends BlocBase {

  Cart _cart = Cart();

  final _productsController = BehaviorSubject<List<Product>>(); // this stream will be handle our stream
  Sink<List<Product>> get _inProducts => _productsController.sink; // it's used for this class so it should be private variable and it not call outside of the class
  Stream<List<Product>> get outProducts => _productsController.stream; // it's used out of the class and other classes so it should be public variable
  /// استریم مانند یه لوله میمونه که سینک در سمت چپ ان است و برای این داده را در داخل ان قرار دهیم و استریم در سمت راست این لوله است برای اینکه دادهایی که قرار گرفته در کلاس های دیگر استفاده کنیم


  // we need another controller for counting products
  final _countController = BehaviorSubject<int>();
  Sink<int> get _inCount =>  _countController.sink;
  Stream<int> get outCount => _countController.stream;

  @override
  void dispose() {
    _productsController.close();
    _countController.close();
  }

  void addProduct(Product product){
//    assert(product == null); // *** for debugging
    final products = _cart.products;
    if(products.contains(product)){
      // if in cart exist product
      products[products.indexOf(product)].amount++;
    }else{
      // if product doesn't in cart
      product.amount = 1;
      products.add(product);
    }

    _cart.itemCount++;
    _inCount.add(_cart.itemCount);
    _inProducts.add(products);
  }

}