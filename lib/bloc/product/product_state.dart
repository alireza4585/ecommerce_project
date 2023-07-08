import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product_image.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/properties.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVarint>> productVariant;
  Either<String, List<Property>> ProductProperty;
  Either<String, Category> category;

  ProductDetailResponseState(this.productImages, this.productVariant,
      this.category, this.ProductProperty);
}
