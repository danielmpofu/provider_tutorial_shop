// import 'package:dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorial_shop/util/data_class.dart';
import 'package:provider_tutorial_shop/widgets/product_gridview.dart';

class ShopCart extends StatefulWidget {
  const ShopCart({Key? key}) : super(key: key);

  @override
  State<ShopCart> createState() => _ShopCartState();
}


class _ShopCartState extends State<ShopCart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(builder: (context, shopProvider, child) {
      return
        Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
          ),
          body: ProductsGridView(
            products: shopProvider.cartItems,
            isCart: true,
          ),
        );
    });
  }
}