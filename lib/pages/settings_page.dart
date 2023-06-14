import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onno_rokom/models/order_constants_model.dart';
import 'package:onno_rokom/providers/order_provider.dart';
import 'package:onno_rokom/utils/constants.dart';
import 'package:onno_rokom/utils/helper_function.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  static const String routeName = '/setting';
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late OrderProvider orderProvider;
  double deliverychargeslidervalue = 0;
  double discountslidervalue = 0;
  double vatslidervalue = 0;

  bool needUpdate = false;

  @override
  void didChangeDependencies() {
    orderProvider = Provider.of(context,listen: false);
    orderProvider.getOrderConstant2().then((value) {
      setState(() {
        deliverychargeslidervalue = orderProvider.orderConstantsModel.deliveryCharge.toDouble();
        discountslidervalue = orderProvider.orderConstantsModel.discount.toDouble();
        vatslidervalue = orderProvider.orderConstantsModel.vat.toDouble();
      });
    });


    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            title: const Text('Delivery charge'),
            trailing: Text('$currencysymbol ${deliverychargeslidervalue.round()}'),
            subtitle: Slider(
              activeColor: Colors.deepPurple.shade300,
              inactiveColor: Colors.grey,
              min: 0,
              max: 500,
              divisions: 50,
              label: deliverychargeslidervalue.toStringAsFixed(0),
              value: deliverychargeslidervalue.toDouble(),
              onChanged: (value){
                setState(() {
                  deliverychargeslidervalue = value;
                  _checkUpdate();
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Discount'),
            trailing: Text(' ${discountslidervalue.round()}%'),
            subtitle: Slider(
              activeColor: Colors.deepPurple.shade300,
              inactiveColor: Colors.grey,
              min: 0,
              max: 100,
              divisions: 100,
              label: discountslidervalue.toStringAsFixed(0),
              value: discountslidervalue.toDouble(),
              onChanged: (value){
                setState(() {
                  discountslidervalue = value;
                  _checkUpdate();
                });

              },
            ),
          ),
          ListTile(
            title: const Text('VAT'),
            trailing: Text('${vatslidervalue.round()}%'),
            subtitle: Slider(
              activeColor: Colors.deepPurple.shade300,
              inactiveColor: Colors.grey,
              min: 0,
              max: 300,
              divisions: 300,
              label: vatslidervalue.toStringAsFixed(0),
              value: vatslidervalue.toDouble(),
              onChanged: (value){
                setState(() {
                  vatslidervalue = value;
                  _checkUpdate();
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: needUpdate ? () {
                EasyLoading.show(
                  status: 'Updating.....', dismissOnTap: false
                ); 
                final model = OrderConstantsModel(
                  deliveryCharge:  deliverychargeslidervalue,
                  discount: discountslidervalue,
                  vat: vatslidervalue,
                );
                orderProvider.addOrderConstants(model).then((value) {
                  setState(() {
                    needUpdate = false;
                  });
                  EasyLoading.dismiss();
                }).catchError((error){
                  showMsg(context, 'Could not update');
                  EasyLoading.dismiss();
                  throw error;
                });
              }: null,
              child: const Text('UPDATE'),
          ),
        ],
      ),
    );
  }

  void _checkUpdate() {
    needUpdate =orderProvider.orderConstantsModel.deliveryCharge.toDouble() !=
    deliverychargeslidervalue ||
        orderProvider.orderConstantsModel.discount.toDouble() !=
        discountslidervalue ||
        orderProvider.orderConstantsModel.vat.toDouble() !=
        vatslidervalue;
  }
}
