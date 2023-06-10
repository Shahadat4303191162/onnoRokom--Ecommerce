import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/order';
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
    );
  }
}
