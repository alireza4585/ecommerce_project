import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/datasource/basket_datasource.dart';
import 'package:apple_shop/data/datasource/category_datasource.dart';
import 'package:apple_shop/data/datasource/category_product.dart';
import 'package:apple_shop/data/datasource/product_data_source.dart';
import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //componenets
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  //datasources
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICategoryDatasource>(() => CategoryRemoteDatasource());
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IProductDataSource>(() => ProductRemoteDataSource());
  locator.registerFactory<IDetailProductDatasource>(
      () => DetailProductRemoteDatasource());
  locator.registerFactory<ICategoryProductDatasource>(
      () => CategoryProductRemoteDatasource());
  locator.registerFactory<IBasketDatasource>(() => BasketLocalDatasource());

  //repositories
  locator.registerFactory<IAuthRepository>(() => AuthencticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IDetailProductRepository>(
      () => DetailProductRepository());
  locator.registerFactory<ICategoryProductRepository>(
      () => CategoryProductRepository());
  locator.registerFactory<IBaskeRepository>(() => BasketRepository());

  //bloc

  locator.registerSingleton<BasketBloc>(BasketBloc());
}
