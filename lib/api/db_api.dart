import 'package:flutter_bloc_pattern/models/category.dart';
import 'package:flutter_bloc_pattern/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbApi {
  // this method is responsible for getting list =>  *** this method is mockup ***
  /*List<Category> getCategories(){
    List<Category> tempList = [Category(),Category(),Category(),Category()];
    return tempList;
  }*/

  // *** this method is really get data from firestore
  Stream<QuerySnapshot> getCategories() {
    Firestore db = Firestore.instance;
    try {
      Stream<QuerySnapshot> querySnapshot = db.collection('Categories').snapshots(); // return the stream of datas
      return querySnapshot;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // *** this method is used for mock up test
  /*List<Product> getProducts(Category category) {
    List<Product> tempList = [
      Product.create('product'),
      Product.create('product'),
      Product.create('product'),
      Product.create('product')
    ];
    return tempList;
  }*/

  // *** this method is really get data from firestore
  Stream<QuerySnapshot> getProducts(Category category) {
    Firestore db = Firestore.instance;
    try {
      Stream<QuerySnapshot> querySnapshot = db.collection('Categories').document(category.id).collection('parts').snapshots(); // return the stream of datas
      return querySnapshot;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
