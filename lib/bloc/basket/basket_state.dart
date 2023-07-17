import 'package:dartz/dartz.dart';

import '../../data/model/card_item.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  int FinalPrice;
  BasketDataFetchedState(this.basketItemList, this.FinalPrice);
}
