import 'package:flutter/material.dart';
import 'package:onno_rokom/models/notification_model.dart';
import 'package:onno_rokom/pages/order_page.dart';
import 'package:onno_rokom/providers/notification_provider.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notification';
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.notificationList.length,
          itemBuilder: (context, index) {
            final notification = provider.notificationList[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                onTap: (){
                  _navigate(context,notification,provider);
                },
                tileColor: notification.status? null : Colors.grey.withOpacity(.5),
                title: Text(notification.type),
                subtitle: Text(notification.message),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigate(BuildContext context, NotificationModel notification,
      NotificationProvider provider) {
        String routeName = '';
        String id = '';
        switch (notification.type) {
          case NotificationType.order:
            routeName = OrderPage.routeName;
            id = notification.orderModel!.orderId!;
            break;

        }
  }
}
