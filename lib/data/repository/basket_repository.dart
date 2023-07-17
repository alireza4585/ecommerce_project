import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dartz/dartz.dart';

import '../../util/api_exception.dart';
import '../datasource/basket_datasource.dart';

abstract class IBaskeRepository {
  Future<Either<String, String>> addProductTobasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItems();
  Future<Either<String, int>> getfinal();
}

class BasketRepository extends IBaskeRepository {
  final IBasketDatasource _datasource = locator.get();
  @override
  Future<Either<String, String>> addProductTobasket(
      BasketItem basketItem) async {
    try {
      _datasource.addProduct(basketItem);
      return right('add product to basket');
    } catch (ex) {
      return left('خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItemList = await _datasource.getAllBasketItem();
      return right(basketItemList);
    } catch (ex) {
      return left('error');
    }
  }

  @override
  Future<Either<String, int>> getfinal() async {
    try {
      var fialprice = await _datasource.finalPrice();
      return right(fialprice);
    } catch (ex) {
      return left('error');
    }
  }
}
