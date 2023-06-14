
import 'package:flutter/material.dart';
import 'package:onno_rokom/db/dbhepler.dart';
import 'package:onno_rokom/models/order_constants_model.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();
  //query korar age object cr korlam cz default value 0


  getOrderConstant(){
    DbHelper.getOrderConstants().listen((event) {
      if(event.exists){
        orderConstantsModel = OrderConstantsModel.fromMap(event.data()!);
        notifyListeners();
      }
    });
  }

  Future<void> getOrderConstant2() async{
    final snapshot = await DbHelper.getOrderConstants2();
    orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
    notifyListeners();
  }

  Future<void> addOrderConstants(OrderConstantsModel model)=>
      DbHelper.addOrderConstants(model);

}