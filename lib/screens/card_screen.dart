import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/card_item.dart';
import 'package:apple_shop/util/string_extensions.dart';

import 'package:apple_shop/widgets/cached_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

class CardScreen extends StatefulWidget {
  CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  Widget build(BuildContext context) {
    @override
    void initState() {
      // for listen to deeplinke

      super.initState();
    }

    var box = Hive.box<BasketItem>('CardBox');

    return Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        body: SafeArea(child: BlocBuilder<BasketBloc, BasketState>(
          builder: ((context, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 44, right: 44, bottom: 32),
                        child: Container(
                          height: 46,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Image.asset('assets/images/icon_apple_blue.png'),
                              const Expanded(
                                child: Text(
                                  'سبد خرید',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'sb',
                                      fontSize: 16,
                                      color: CustomColors.blue),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (state is BasketDataFetchedState) ...{
                      state.basketItemList.fold(((l) {
                        return SliverToBoxAdapter(
                          child: Text(l),
                        );
                      }), ((basketItemList) {
                        return SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return CardItem(basketItemList[index]);
                          }, childCount: basketItemList.length),
                        );
                      }))
                    },
                    SliverPadding(padding: EdgeInsets.only(bottom: 100))
                  ],
                ),
                if (state is BasketDataFetchedState) ...{
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 44, right: 44, bottom: 20),
                    child: SizedBox(
                      height: 53,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle:
                                  TextStyle(fontSize: 18, fontFamily: 'sm'),
                              backgroundColor: CustomColors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            context
                                .read<BasketBloc>()
                                .add(BasketPaymentEvent());
                            context
                                .read<BasketBloc>()
                                .add(BasketPaymentRequestEvent());
                          },
                          child: Text((state.FinalPrice == 0)
                              ? 'سبد خرید شما خالیه '
                              : '${state.FinalPrice}')),
                    ),
                  )
                }
              ],
            );
          }),
        )));
  }
}

// ignore: camel_case_types, must_be_immutable

class CardItem extends StatelessWidget {
  BasketItem basketItem;
  CardItem(
    this.basketItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249,
      margin: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'ایفون ۱۳ پرومکس',
                          style: TextStyle(fontFamily: 'sb', fontSize: 16),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'گارانتی فیلان ۱۸ ماهه',
                          style: TextStyle(fontFamily: 'sm', fontSize: 12),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 6),
                                child: Text(
                                  '٪۳',
                                  style: TextStyle(
                                      fontFamily: 'sb',
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text('تومان',
                                style:
                                    TextStyle(fontFamily: 'sm', fontSize: 12)),
                            SizedBox(
                              width: 4,
                            ),
                            Text('۴۹.۱۲۳.۱۲۳',
                                style:
                                    TextStyle(fontFamily: 'sm', fontSize: 12))
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CustomColors.red, width: 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, bottom: 2, right: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('حذف',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontFamily: 'sm',
                                            fontSize: 12,
                                            color: CustomColors.red)),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Image.asset('assets/images/icon_trash.png')
                                  ],
                                ),
                              ),
                            ),
                            OptionCheap(
                              'آبی',
                              color: 'eb34b4',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                      height: 104,
                      width: 75,
                      child: CachedImage(imageUrl: basketItem.thumbnail)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 3.0,
              dashLength: 8.0,
              dashColor: CustomColors.gery.withOpacity(0.5),
              dashGapLength: 3.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('تومان', style: TextStyle(fontFamily: 'sb', fontSize: 16)),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '59.000.000',
                  style: TextStyle(fontFamily: 'sb', fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  String? color;
  String title;
  OptionCheap(this.title, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.gery, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10,
            ),
            if (color != null) ...{
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parseToColor(),
                ),
              )
            },
            Text(title,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'sm', fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

//expertflutter://shop?authority=13232432342344342&status=ok
String? _extractValueFromQuery(String url, String key) {
  // Remove everything before the question mark
  int queryStartIndex = url.indexOf('?');
  if (queryStartIndex == -1) return null;

  String query = url.substring(queryStartIndex + 1);

  // Split the query into key-value pairs
  List<String> pairs = query.split('&');

  // Find the key-value pair that matches the given key
  for (String pair in pairs) {
    List<String> keyValue = pair.split('=');
    if (keyValue.length == 2) {
      String currentKey = keyValue[0];
      String value = keyValue[1];

      if (currentKey == key) {
        // Decode the URL-encoded value
        return Uri.decodeComponent(value);
      }
    }
  }

  return null;
}
