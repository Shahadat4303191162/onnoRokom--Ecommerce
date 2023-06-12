import 'package:firebase_auth/firebase_auth.dart';
import 'package:onno_rokom/db/dbhepler.dart';

class AuthService{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final User? user =_auth.currentUser;


  static Future<bool> login (String email,String pass) async{
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: pass);/*1.1 email ba pass vul hole next line e jabe na jabe login e*/
    return DbHelper.isAdmin(credential.user!.uid);
  }
  static Future<void> logout() => _auth.signOut();
}