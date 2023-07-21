import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onno_rokom/models/cart_moder.dart';
import 'package:onno_rokom/models/order_model.dart';
import 'package:onno_rokom/providers/order_provider.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class OrderDetailsPage extends StatelessWidget {
  static const String routeName = '/order_details';

  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    final provider = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: provider.getAllOrdersByOrderId(order.orderId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final detailsList = List.generate(
                  snapshot.data!.docs.length,
                  (index) =>
                      CartModel.fromMap(snapshot.data!.docs[index].data()));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Text(
                      'Product Info',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Card(
                      elevation: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: detailsList
                            .map((cartM) => ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(cartM.imageUrl!)),
                                  title: Text(cartM.productName!),
                                  trailing: Text(
                                      '${cartM.quantity}X$currencysymbol ${cartM.salePrice}'),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Delivery Address',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 18.0),
                      child: Text('${order.deliveryAddress.streetAddress}\n'
                      '${order.deliveryAddress.area}, ${order.deliveryAddress.city}\n'
                          '${order.deliveryAddress.zipCode}'
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Payment Info',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Delivery Charge'),
                                Text('${order.deliveryCharge}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Discount'),
                                Text('$currencysymbol${order.discount}%'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('VAT'),
                                Text('${order.vat}%'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Grand Total', style: Theme.of(context).textTheme.headline6),
                                Text('$currencysymbol${order.grandTotal}', style: Theme.of(context).textTheme.headline6),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to get data'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
      ),
    );
  }
}
