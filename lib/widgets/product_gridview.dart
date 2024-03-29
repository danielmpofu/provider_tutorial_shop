import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorial_shop/model/Product.dart';
import 'package:provider_tutorial_shop/util/data_class.dart';
import 'package:provider_tutorial_shop/widgets/product_grid_item.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;
  final bool isCart;

  const ProductsGridView({required this.products, required this.isCart});

  @override
  Widget build(BuildContext context) {
    var shopActions = Provider.of<ShopProvider>(context, listen: false);

    return MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: products.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext ctx, index) {
          return ProductGridItem(product: products[index], isCart: isCart);
        });
  }
}
