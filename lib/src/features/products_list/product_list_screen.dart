import 'package:coffee_shop/src/common_widgets/responsive_center.dart';
import 'package:coffee_shop/src/constants/app_sizes.dart';
import 'package:coffee_shop/src/features/home_app_bar/home_app_bar.dart';
import 'package:coffee_shop/src/features/products_list/products_grid.dart';
import 'package:coffee_shop/src/features/products_list/products_search_text_field.dart';
import 'package:flutter/material.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: ProductsSearchTextField(),
          ),
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: ProductsGrid(),
          ),
        ],
      ),
    );
  }
}
