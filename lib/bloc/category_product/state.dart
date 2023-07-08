import 'package:apple_shop/data/model/product.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryProductState {}

class CategoryProductLoadingState extends CategoryProductState {}

class CategoryProductResponseSuccessState extends CategoryProductState {
  Either<String, List<Product>> productListByCategory;

  CategoryProductResponseSuccessState(this.productListByCategory);
}
