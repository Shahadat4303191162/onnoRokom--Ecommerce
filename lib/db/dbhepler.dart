import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper{

  static const String collectionAdmin = 'Admins';
  static const String collectionCategory = 'categories';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;


  static Future<bool> isAdmin (String uid) async{  //ei Uid nam e ado firebase coll e kono doc ace ki na ta check kore true or false return korbe
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;

  }


  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllCategories() =>
      _db.collection(collectionCategory).snapshots();
}