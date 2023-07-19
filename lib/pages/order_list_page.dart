import 'package:flutter/material.dart';
import 'package:onno_rokom/providers/order_provider.dart';
import 'package:onno_rokom/utils/constants.dart';
import 'package:onno_rokom/utils/helper_function.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName = '/order_list';
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = ModalRoute.of(context)!.settings.arguments as OrderFilter;
    final orderList = Provider.of<OrderProvider>(context,listen: false).getFilteredList(filter);
    orderList.sort((orderM1,orderM2) => orderM2.orderDate.timestamp.compareTo(orderM1.orderDate.timestamp));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
      body: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            final order = orderList[index];
            return ListTile(
              title: Text(getFormattedDateTime(order.orderDate.timestamp.toDate(), 'dd/MM/yyyy hh:mm:ss a')),
              subtitle: Text(order.orderStatus),
              trailing: Text('$currencysymbol${order.grandTotal}'),
            );
          },),
    );
  }
}
