
import 'package:onno_rokom/models/order_model.dart';
import 'package:onno_rokom/models/user_model.dart';

const String notificationFieldId = 'notificationId';
const String notificationFieldType = 'type';
const String notificationFieldMessage = 'message';
const String notificationFieldStatus = 'status';
const String notificationFieldUser = 'user';
const String notificationFieldOrder = 'order';

class NotificationModel{
  String id,type,message;
  bool status;
  OrderModel? orderModel;
  UserModel? userModel;

  NotificationModel(
      {
      required this.id,
      required this.type,
      required this.message,
      this.status = false,
      this.orderModel,
      this.userModel,
     });

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      notificationFieldId: id,
      notificationFieldMessage: message,
      notificationFieldType: type,
      notificationFieldStatus: status,
      notificationFieldOrder: orderModel?.toMap(),
      notificationFieldUser: userModel?.toMap(),
    };
  }

  factory NotificationModel.fromMap(Map<String,dynamic> map) =>
      NotificationModel(
          id: map[notificationFieldId],
          type: map[notificationFieldType],
          message: map[notificationFieldMessage],
          userModel: map[notificationFieldUser] ==null? null
              :UserModel.fromMap(map[notificationFieldUser]),
          orderModel: map[notificationFieldOrder] == null? null
              :OrderModel.fromMap(map[notificationFieldOrder]),
      );
}