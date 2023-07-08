import 'package:apple_shop/bloc/category_product/bloc.dart';
import 'package:apple_shop/bloc/category_product/event.dart';
import 'package:apple_shop/bloc/category_product/state.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInitialize(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
          child: BlocBuilder<CategoryProductBloc, CategoryProductState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              titile(widget: widget),
              if (state is CategoryProductResponseSuccessState) ...{
                state.productListByCategory.fold(
                  (l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  },
                  (r) {
                    return product(r);
                  },
                )
              }
            ],
          );
        },
      )),
    );
  }
}

class product extends StatelessWidget {
  List<Product> products;
  product(
    this.products, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(((context, index) {
          //   return ProductItem();
          return ProductItem(products[index]);
        }), childCount: products.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2.8,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30),
      ),
    );
  }
}

class titile extends StatelessWidget {
  const titile({
    super.key,
    required this.widget,
  });

  final ProductListScreen widget;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 32),
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
              Expanded(
                child: Text(
                  widget.category.title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'sb', fontSize: 16, color: CustomColors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
