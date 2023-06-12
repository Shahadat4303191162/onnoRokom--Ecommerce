const String productId = 'id';
const String productName = 'name';
const String productCategory = 'category';
const String productDescription = 'description';
const String productImageUrl = 'imageUrl';
const String productSalesPrice = 'salesPrice';
const String productFeatured = 'featured';
const String productAvailable = 'available';

class ProductModel{
  String? id,name,category,description,imageUrl;
  num salesPrice;
  bool featured,available;

  ProductModel(
      {this.id,
      this.name,
      this.category,
      this.description,
      this.imageUrl,
      required this.salesPrice,
      this.featured =true,
      this.available = true,
      });

  Map<String,dynamic>toMap(){
    return<String,dynamic>{
      productId : id,
      productName : name,
      productCategory : category,
      productDescription : description,
      productImageUrl : imageUrl,
      productSalesPrice : salesPrice,
      productFeatured : featured,
      productAvailable : available,
    };
  }

  factory ProductModel.fromMap(Map<String,dynamic>map){
    return ProductModel(
        id: map[productId],
        name: map[productName],
        category: map[productCategory],
        description: map[productDescription],
        imageUrl: map[productImageUrl],
        salesPrice: map [productSalesPrice],
        available: map[productAvailable],
        featured: map[productFeatured],
    );
  }
}