import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onno_rokom/models/product_model.dart';
import 'package:onno_rokom/providers/product_porvider.dart';
import 'package:onno_rokom/utils/constants.dart';
import 'package:onno_rokom/utils/helper_function.dart';
import 'package:provider/provider.dart';

import '../models/data_model.dart';
import '../models/purchase_model.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/product_details';
  ValueNotifier<DateTime> dateChangeNotifier = ValueNotifier(DateTime.now());
  ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    dateChangeNotifier.value = DateTime.now();
    final pid = ModalRoute.of(context)!.settings.arguments as String;
    final provider = Provider.of<ProductProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getProductById(pid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
              provider.getAllPurchasesByProductId(pid);
              return ListView(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'images/loading.gif',
                    image: product.imageUrl!,
                    fadeInDuration: const Duration(seconds: 1),
                    fadeInCurve: Curves.bounceInOut,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            _showRePurchaseForm(context,provider,product);
                          },
                        child: const Text('Re-Purchase'),),
                      TextButton(
                          onPressed: () {
                            _showPurchaseHistory(context,provider);
                          },
                          child: const Text('Purchase History'),),
                    ],
                  ),
                  ListTile(
                    title: Text(product.name!),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: const Text('Sales Price'),
                    subtitle: Text(
                      '$currencysymbol ${product.salesPrice}',
                      style: const TextStyle(color: Colors.green),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                  ListTile(
                    title: const Text('Product Description'),
                    subtitle: Text(product.description ?? 'Not Available'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                  SwitchListTile(
                      title: const Text('Available'),
                      value: product.available,
                      onChanged: (value) {
                        provider.updateProduct(pid, productAvailable, value);
                      }),
                  SwitchListTile(
                      title: const Text('Featured'),
                      value: product.featured,
                      onChanged: (value) {
                        provider.updateProduct(pid, productFeatured, value);
                      })
                ],
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

  void _showPurchaseHistory(BuildContext context, ProductProvider provider) {
    showModalBottomSheet(context: context, builder: (context) =>
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1),
            itemCount: provider.purchaseListOfSpecificProduct.length,
            itemBuilder: (context, index) {
              //purchase model ta ber korar jonn ni
              final purchase = provider.purchaseListOfSpecificProduct[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(getFormattedDateTime(purchase.dateModel.timestamp.toDate(), 'dd/MM/yyyy'),),
                    subtitle: Text('Quentity: ${purchase.quantity}'),
                    trailing: Text('$currencysymbol ${purchase.price}'),
                  ),
                ),
              );
            },
        ),
    );
  }

  void _showRePurchaseForm(BuildContext context, ProductProvider provider, ProductModel productModel) {
    final qController = TextEditingController();
    final priceController = TextEditingController();
    showModalBottomSheet(context: context, builder: (context) =>
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              title: Text('Re-Purchase ${productModel.name}'),
            ),
            TextField(
              controller: qController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Enter Quantity'
              ),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Enter Price'
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        final _purchaseDate = await _selectDate(context);
                        dateChangeNotifier.value = _purchaseDate;
                      },
                      child: const Text('Select Purchase Date')),
                  ValueListenableBuilder(
                    valueListenable: dateChangeNotifier,
                    builder: (context, value, child) =>
                        Text(getFormattedDateTime(value, 'dd/MM/yyyy')),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final purchase = PurchaseModel(
                  dateModel: DateModel(
                    timestamp: Timestamp.fromDate(dateChangeNotifier.value),
                    day: dateChangeNotifier.value.day,
                    month: dateChangeNotifier.value.month,
                    year: dateChangeNotifier.value.year,
                  ),
                  price: num.parse(priceController.text),
                  quantity: num.parse(qController.text),
                  productId: productModel.id,
                );
                provider.addNewPurchase(purchase,productModel.category!/* 1.1 Re-purchase product add for category*/,productModel.stock).then((value) {
                  qController.clear();
                  priceController.clear();
                  Navigator.pop(context);
                }).catchError((onError) {
                  Navigator.pop(context);
                  showMsg(context, 'Failed to perform......');
                });
              },
              child: const Text('Re-Purchase'),
            )
          ],
        ),
    );
  }
  Future<DateTime> _selectDate(BuildContext context) async {
    return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime.now()) ?? DateTime.now();
  }
}
