import 'package:flutter/material.dart';
import 'package:onno_rokom/providers/product_porvider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/categories';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final namController = TextEditingController();
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

      bottomSheet: DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.5,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Card(
            color: Colors.purple.shade100,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              controller: scrollController,
              children: [
                const Center(
                  child: Icon(Icons.drag_handle),
                ),
                const ListTile(
                  title: Text('ADD CATEGORY'),
                ),
                TextField(
                  controller: namController,
                  decoration: const InputDecoration(
                    hintText: 'Enter new Category',
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () async{
                      if(namController.text.isEmpty){
                        return;
                      }else{
                        Provider
                            .of<ProductProvider>(context,listen: false)
                            .addCategory(namController.text);
                        namController.clear();
                      }
                    },
                    child: const Text('ADD'))
              ],
            ),
          );
        },
      ),
    );
  }
}
