import 'package:flutter/material.dart';
import 'package:onno_rokom/db/dbhepler.dart';

import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier{
  List<NotificationModel> notificationList = [];

  getAllNotification(){
    DbHelper.getAllNotification().listen((snapshot) {
      notificationList = List.generate(snapshot.docs.length, (index) =>
        NotificationModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}