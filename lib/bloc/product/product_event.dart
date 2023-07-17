import 'package:apple_shop/data/model/product.dart';

abstract class ProductEvent {}

class ProductInitializeEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializeEvent(this.productId, this.categoryId);
}

class ProductAddTobasket extends ProductEvent {
  Product product;
  ProductAddTobasket(this.product);
}
