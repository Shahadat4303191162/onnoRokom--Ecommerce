import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/product_details';
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
    );
  }
}
