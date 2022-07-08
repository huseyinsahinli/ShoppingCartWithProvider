import 'dart:convert';

class Product {
  late final int? id;
  final String? productId;
  final String? productName;

  final int? productInitialPrice;
  final double? productPrice;
  final int? productStock;
  final int? productQuantity;
  final String? productImage;
  Product({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productInitialPrice,
    required this.productPrice,
    required this.productStock,
    required this.productQuantity,
    required this.productImage,
  });
  static String imagePath = 'assets/images/';
  static List<Product> products = [
    Product(
      id: 1,
      productId: '1001',
      productName: 'Apple',
      productInitialPrice: 5,
      productPrice: 5,
      productStock: 50,
      productQuantity: 1,
      productImage: '${imagePath}apple.jpg',
    ),
    Product(
      id: 2,
      productId: '1002',
      productName: 'Carrot',
      productInitialPrice: 4,
      productPrice: 4,
      productStock: 75,
      productQuantity: 1,
      productImage: '${imagePath}carrot.jpg',
    ),
    Product(
      id: 3,
      productId: '1003',
      productName: 'Patato',
      productInitialPrice: 10,
      productPrice: 10,
      productStock: 20,
      productQuantity: 1,
      productImage: '${imagePath}patato.jpg',
    ),
    Product(
      id: 4,
      productId: '1004',
      productName: 'Cherry',
      productInitialPrice: 7,
      productPrice: 7,
      productStock: 45,
      productQuantity: 1,
      productImage: '${imagePath}cherry.jpg',
    ),
  ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productInitialPrice': productInitialPrice,
      'productPrice': productPrice,
      'productStock': productStock,
      'productQuantity': productQuantity,
      'productImage': productImage,
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        productId = map['productId'],
        productName = map['productName'],
        productInitialPrice = map['productInitialPrice'],
        productPrice = map['productPrice'],
        productStock = map['productStock'],
        productQuantity = map['productQuantity'],
        productImage = map['productImage'];

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, productId: $productId, productName: $productName,productInitialPrice: $productInitialPrice productPrice: $productPrice, productStock: $productStock, productQuantity: $productQuantity productImage: $productImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.productId == productId &&
        other.productName == productName &&
        other.productInitialPrice == productInitialPrice &&
        other.productPrice == productPrice &&
        other.productStock == productStock &&
        other.productQuantity == productQuantity &&
        other.productImage == productImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        productName.hashCode ^
        productInitialPrice.hashCode ^
        productPrice.hashCode ^
        productStock.hashCode ^
        productQuantity.hashCode ^
        productImage.hashCode;
  }
}
