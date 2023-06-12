import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onno_rokom/models/category_model.dart';

import '../models/product_model.dart';
import '../models/purchase_model.dart';

class DbHelper{

  static const String collectionAdmin = 'Admins';
  static const String collectionCategory = 'categories';
  static const String collectionProduct = 'product';
  static const String collectionPurchase = 'purchases';
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

  static Future<void> addNewPurchase(PurchaseModel purchaseModel){
    final doc = _db.collection(collectionPurchase).doc();
    purchaseModel.id = doc.id;
    return doc.set(purchaseModel.toMap());
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

  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllPurchaseByProduct(String pid) =>
      _db.collection(collectionPurchase)
          .where(purchaseProductId, isEqualTo: pid)
          .snapshots();

  static Stream<DocumentSnapshot<Map<String,dynamic>>> getProductById(String id) =>
      _db.collection(collectionProduct).doc(id).snapshots();

  static Future<void> updateProduct(String id, Map<String,dynamic>map) =>
       _db.collection(collectionProduct).doc(id).update(map);
}