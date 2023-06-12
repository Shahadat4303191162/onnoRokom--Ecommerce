import 'package:flutter/material.dart';
import 'package:onno_rokom/db/dbhepler.dart';
import 'package:onno_rokom/models/product_model.dart';

import '../models/category_model.dart';

class ProductProvider extends ChangeNotifier{
  List<ProductModel> productList = [];
  List<CategoryModel> categoryList = [];

  getAllCategories(){
    DbHelper.getAllCategories().listen((snapshot){
      categoryList = List.generate(snapshot.docs.length, (index) =>
        CategoryModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

}