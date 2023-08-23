import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onno_rokom/models/category_model.dart';
import 'package:onno_rokom/models/order_constants_model.dart';

import '../models/product_model.dart';
import '../models/purchase_model.dart';

class DbHelper{

  static const String collectionAdmin = 'Admins';
  static const String collectionCategory = 'categories';
  static const String collectionProduct = 'product';
  static const String collectionPurchase = 'purchases';
  static const String collectionOrderSettings = 'settings';
  static const String documentOrderConstant = 'orderConstant';
  static const String collectionRating = 'Rating';
  static const String collectionComment = 'Comment';
  static const String collectionUsers = 'Users';
  static const String collectionCart = 'Cart';
  static const String collectionOrder = 'Order';
  static const String collectionOrderDetails = 'OrderDetails';
  static const String collectionCities = 'Cities';
  static const String collectionNotification = 'Notification';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;


  static Future<bool> isAdmin (String uid) async{  //ei Uid nam e ado firebase coll e kono doc ace ki na ta check kore true or false return korbe
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;

  }

  static Future<void> addCategory(CategoryModel categoryModel){
    final doc = _db.collection(collectionCategory).doc();
    categoryModel.id = doc.id;
    return doc.set(categoryModel.toMap());
  }

  static Future<void> addOrderConstants (OrderConstantsModel model){
    return _db.collection(collectionOrderSettings)
        .doc(documentOrderConstant).set(model.toMap());

  }

  static Future<void> addNewPurchase(
      PurchaseModel purchaseModel,
      CategoryModel catModel, num newStock/* 1.2 Re-purchase product add for category*/){
    final wb = _db.batch();//object
    final doc = _db.collection(collectionPurchase).doc();
    final catDoc = _db.collection(collectionCategory).doc(catModel.id);
    //dui tar i doc gula update kore nilam
    purchaseModel.id = doc.id;
    wb.set(doc, purchaseModel.toMap());
    wb.update(catDoc, {categoryProductCount : catModel.productCount});
    final proDoc = _db.collection(collectionProduct).doc(purchaseModel.productId);
    wb.update(proDoc, {productStock : newStock});

    return wb.commit();
  }

  static Future<void> addProduct(
      ProductModel productModel,
      PurchaseModel purchaseModel,
      String catId, num count) {
    final wb = _db.batch();
    final proDoc = _db.collection(collectionProduct).doc();
    final purDoc = _db.collection(collectionPurchase).doc();
    final catDoc = _db.collection(collectionCategory).doc(catId);
    productModel.id = proDoc.id;
    purchaseModel.id = purDoc.id;
    purchaseModel.productId = proDoc.id;
    wb.set(proDoc, productModel.toMap());
    wb.set(purDoc, purchaseModel.toMap());
    wb.update(catDoc, {'productCount' : count});
    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllProduct() =>
      _db.collection(collectionProduct).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllOrders() =>
      _db.collection(collectionOrder).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllOrdersByOrderId(String oid) =>
      _db.collection(collectionOrder).doc(oid).collection(collectionOrderDetails).snapshots();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllPurchaseByProduct(String pid) =>
      _db.collection(collectionPurchase)
          .where(purchaseProductId, isEqualTo: pid)
          .snapshots();

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getProductById(String id) =>
      _db.collection(collectionProduct).doc(id).snapshots();

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getOrderConstants() => /*2.1 orderSettings*/
      _db.collection(collectionOrderSettings).doc(documentOrderConstant).snapshots();

  static Future<DocumentSnapshot<Map<String,dynamic>>> getOrderConstants2() => /*2.1 orderSettings*/
  _db.collection(collectionOrderSettings).doc(documentOrderConstant).get();

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllNotification()=>
    _db.collection(collectionNotification).snapshots();

  static Future<void> updateProduct(String id, Map<String,dynamic>map) =>
       _db.collection(collectionProduct).doc(id).update(map);
}