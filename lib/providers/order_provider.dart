
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onno_rokom/db/dbhepler.dart';
import 'package:onno_rokom/models/order_constants_model.dart';
import 'package:onno_rokom/models/order_model.dart';
import 'package:onno_rokom/utils/constants.dart';

class OrderProvider extends ChangeNotifier{
  List<OrderModel> orderList = [];
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

  void getAllOrders() {
    DbHelper.getAllOrders().listen((snapshot){
      orderList = List.generate(snapshot.docs.length, (index) =>
          OrderModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> getAllOrdersByOrderId(String oid) {
    return DbHelper.getAllOrdersByOrderId(oid);
  }

  List<OrderModel> getFilteredListBySingleDay(DateTime dt) {
    return orderList.where((orderM) => orderM.orderDate.timestamp.toDate().day == dt.day &&
        orderM.orderDate.timestamp.toDate().month == dt.month &&
        orderM.orderDate.timestamp.toDate().year == dt.year).toList();
  }

  List<OrderModel> getFilteredListByWeek(DateTime dt) {
    return orderList.where((orderM) => orderM.orderDate.timestamp.toDate().isAfter(dt)).toList();
  }

  List<OrderModel> getFilteredListByMonth(DateTime dt) {
    return orderList.where((orderM) =>
        orderM.orderDate.timestamp.toDate().month == dt.month &&
        orderM.orderDate.timestamp.toDate().year == dt.year
    ).toList();
  }

  num getTotalSaleBySingleDate(DateTime dt){
    num total = 0;
    final list = getFilteredListBySingleDay(dt);
    for(var order in list){
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalSaleByWeek(DateTime dt){
    num total = 0;
    final list = getFilteredListByWeek(dt);
    for(var order in list){
      total += order.grandTotal;
    }
    return total.round();
  }

  num getTotalSaleByMonth(DateTime dt){
    num total = 0;
    final list = getFilteredListByMonth(dt);
    for(var order in list){
      total += order.grandTotal;
    }
    return total.round();
  }

  List<OrderModel> getFilteredList(OrderFilter filter){
    var list = <OrderModel>[];

    switch(filter){
      case OrderFilter.TODAY:
        list = getFilteredListBySingleDay(DateTime.now());
        break;

      case OrderFilter.YESTERDAY:
        list = getFilteredListBySingleDay(DateTime.now().subtract(const Duration(days: 1)));
        break;

      case OrderFilter.SEVER_DAYS:
        list = getFilteredListByWeek(DateTime.now().subtract(const Duration(days: 7)));
        break;

      case OrderFilter.THIS_MONTH:
        list = getFilteredListByMonth(DateTime.now());
        break;

      case OrderFilter.ALL_TIME:

        break;
    }
    return list;

  }

}