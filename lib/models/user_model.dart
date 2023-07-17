import 'package:cloud_firestore/cloud_firestore.dart';
import 'adddress_model.dart';

// const String userUid = 'uid';
// const String userName = 'name';
// const String userMobile = 'mobile';
// const String userEmail = 'email';
// const String userImage = 'image';
// const String userDevicetoken = 'devicetoken';
// const String userCreationtime = 'creationtime';


class UserModel {
  String uid;
  String? name;
  String email;
  String? mobile;
  String? image;
  AddressModel? address;
  Timestamp user_creationTime;
  String? deviceToken;

  UserModel(
      {required this.uid,
        this.name,
        required this.email,
        this.mobile,
        this.image,
        this.address,
        required this.user_creationTime,
        this.deviceToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'uid' : uid,
      'name' : name,
      'mobile' : mobile,
      'email' : email,
      'image' : image,
      'address' : address?.toMap(),
      //'address' : address,
      'deviceToken' : deviceToken,
      'userCreationTime' : user_creationTime,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['uid'],
    name: map['name'],
    mobile: map['mobile'],
    email: map['email'],
    image: map['image'],
    //address: AddressModel.fromMap(map['address']),
    address: map['address'] ==null ? null : AddressModel.fromMap(map['address']),
    deviceToken: map['deviceToken'],
    user_creationTime: map['userCreationTime'],
  );
}