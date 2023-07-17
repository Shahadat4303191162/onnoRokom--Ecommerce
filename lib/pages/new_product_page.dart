import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/data_model.dart';
import '../models/product_model.dart';
import '../models/purchase_model.dart';
import '../providers/product_porvider.dart';
import '../utils/helper_function.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/new_product';

  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final namController = TextEditingController();
  final descriptionController = TextEditingController();
  final salePriceController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final quantityController = TextEditingController();
  DateTime? _purchaseDate;
  String? _imageUrl;
  String? _category;
  bool isUploading = false,iSaving = false;
  ImageSource _imageSource = ImageSource.camera;
  final from_key = GlobalKey<FormState>();

  @override
  void dispose() {
    namController.dispose();
    descriptionController.dispose();
    salePriceController.dispose();
    purchasePriceController.dispose();
    quantityController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        actions: [
          IconButton(onPressed: isUploading ? null : _saveProduct, icon: Icon(Icons.save)),
        ],
      ),
      body: Form(
          key: from_key,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              TextFormField(
                controller: namController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: Icon(Icons.drive_file_rename_outline,
                      color: Theme.of(context).primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  prefixIcon: Icon(Icons.description,
                      color: Theme.of(context).primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: purchasePriceController,
                decoration: InputDecoration(
                    labelText: 'Purchase Price',
                    prefixIcon: Icon(Icons.monetization_on_outlined,
                        color: Theme.of(context).primaryColor)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: salePriceController,
                decoration: InputDecoration(
                  labelText: 'Sale Price',
                  prefixIcon: Icon(Icons.monetization_on,
                      color: Theme.of(context).primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  prefixIcon: Icon(Icons.numbers,
                      color: Theme.of(context).primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<ProductProvider>(
                builder: (context, provider, _) =>
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field must not be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                      hint: const Text('Select Category'),
                      value: _category,
                      items: provider.categoryList
                          .map((model) => DropdownMenuItem<String>(
                        value: model.name,
                        child: Text(model.name!),
                      ))
                          .toList(),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: _selectDate,
                        child: Text('Select Purchase Date')),
                    Text(_purchaseDate == null ? 'No Date Chosen' : getFormattedDateTime(_purchaseDate!, 'dd/MM/yyyy')),
                  ],
                ),
              ), //date of birth
              Center(
                child: Card(
                  elevation: 5,
                  child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: _imageUrl == null
                          ? isUploading ?
                      Center(child: CircularProgressIndicator(),):
                      Image.asset(
                        'images/placeholder.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                          : FadeInImage.assetNetwork(
                        placeholder: 'images/loading.gif',
                        image: _imageUrl!,
                        fadeInDuration: const Duration(seconds: 1),
                        fadeInCurve: Curves.bounceInOut,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,)
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _imageSource = ImageSource.camera;
                        _getImage();
                      },
                      child: Text('Camera')),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _imageSource = ImageSource.gallery;
                        _getImage();
                      },
                      child: Text('Gallary')),
                ],
              )
          ],
          ),),
    );
  }

  void _saveProduct() async{
    if(_imageUrl == null) {
      showMsg(context, 'Image required for product');
      return;
    }
    if(_purchaseDate == null) {
      showMsg(context, 'Purchase Date is required');
      return;
    }
    if (from_key.currentState!.validate()) {
      final productModel = ProductModel(
        name: namController.text,
        description: descriptionController.text,
        category: _category,
        salesPrice: num.parse(salePriceController.text),
        imageUrl: _imageUrl,
        stock: num.parse(quantityController.text),
      );
      final purchaseModel = PurchaseModel(
        dateModel: DateModel(
          timestamp: Timestamp.fromDate(_purchaseDate!),
          day: _purchaseDate!.day,
          month: _purchaseDate!.month,
          year: _purchaseDate!.year,
        ),
        price: num.parse(purchasePriceController.text),
        quantity: num.parse(quantityController.text),
      );
      final catModel = context.read<ProductProvider>().getCategoryByName(_category!);
      context.read<ProductProvider>()
          .addProduct(
          productModel,
          purchaseModel,
          catModel).then((value) {
        setState(() {
          namController.clear();
          descriptionController.clear();
          purchasePriceController.clear();
          salePriceController.clear();
          quantityController.clear();
          _purchaseDate = null;
          _imageUrl = null;
          _category = null;
        });
      });
    }
  }

  void _selectDate()  async{
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _purchaseDate = selectedDate;
      });
    }
  }

  void _getImage() async{
    final selecteImage = await ImagePicker().pickImage(source: _imageSource,imageQuality: 75);
    if (selecteImage != null) {
      setState(() {
        isUploading = true;
      });
      try {
        final url =
            await context.read<ProductProvider>().updateImage(selecteImage);
        setState(() {
          _imageUrl = url;
          isUploading = false;
        });
      } catch (e) {}
    }
  }

}
