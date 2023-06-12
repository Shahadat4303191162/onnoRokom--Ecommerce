import 'package:flutter/material.dart';
import 'package:onno_rokom/providers/product_porvider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _)=> provider.categoryList.isEmpty
        ?const Center(
          child: Text('NO Item found',
          style: TextStyle(fontSize: 18),),
        ) : ListView.builder(
          itemCount: provider.categoryList.length,
          itemBuilder: (context, index){
            final category = provider.categoryList[index];
            return ListTile(
              title: Text('${category.name}(${category.productCount})'),
            );
          },
        ),
      ),
      //
      // bottomSheet: DraggableScrollableSheet(
      //   initialChildSize: 0.1,
      //   maxChildSize: 0.1,
      //   minChildSize: 0.5,
      //   builder:
      // ),
    );
  }
}
