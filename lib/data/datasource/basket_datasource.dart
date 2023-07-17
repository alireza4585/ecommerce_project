import 'package:apple_shop/data/model/card_item.dart';
import 'package:hive/hive.dart';

abstract class IBasketDatasource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItem();
  Future<int> finalPrice();
}

class BasketLocalDatasource extends IBasketDatasource {
  var box = Hive.box<BasketItem>('cardbox');
  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItem() async {
    return box.values.toList();
  }

  @override
  Future<int> finalPrice() async {
    var priceBox = box.values.toList();
    var finalPrices = priceBox.fold(0, (index, element) {
      return index + element.realPrice!;
    });
    return finalPrices;
  }
}
