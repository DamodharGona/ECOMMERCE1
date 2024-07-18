class ProductModel {
  final String id;
  final String categoryId;
  final String shopId;
  final String merchantId;
  final String name;
  final double price;
  final String description;
  final List<String> specifications;
  final String imageUrl;
  final bool isOutOfStock;
  final double discountPercent;

  const ProductModel({
    this.id = '',
    this.categoryId = '',
    this.shopId = '',
    this.merchantId = '',
    this.name = '',
    this.price = 0,
    this.description = '',
    this.specifications = const <String>[],
    this.imageUrl = '',
    this.isOutOfStock = false,
    this.discountPercent = 0,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'shopId': shopId,
      'merchantId': merchantId,
      'name': name,
      'price': price,
      'description': description,
      'specifications': specifications,
      'imageUrl': imageUrl,
      'isOutOfStock': isOutOfStock,
      'discountPercent': discountPercent,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      categoryId: map['categoryId'] ?? '',
      shopId: map['shopId'] ?? '',
      merchantId: map['merchantId'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      description: map['description'] ?? '',
      specifications: map['specifications'] != null
          ? List<String>.from((map['specifications'] as List<String>))
          : const <String>[],
      imageUrl: map['imageUrl'] ?? '',
      isOutOfStock: map['isOutOfStock'] ?? false,
      discountPercent: map['discountPercent'] ?? 0,
    );
  }
}
