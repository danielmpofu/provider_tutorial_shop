import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorial_shop/model/Product.dart';
import 'package:provider_tutorial_shop/util/data_class.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;
  final bool isCart;

  const ProductsGridView({required this.products, required this.isCart});

  @override
  Widget build(BuildContext context) {
    var shopActions = Provider.of<ShopProvider>(context, listen: false);
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Material(
              elevation: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 110,
                    child: Image.network("${products[index].image}"),
                  ),
                  SizedBox(
                      width: 200,
                      height: 20,
                      child: Text(
                        "${products[index].title}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.favorite_border),
                      !isCart
                          ? GestureDetector(
                              onTap: () {
                                shopActions.addToCart(products[index]);
                              },
                              child: const Icon(Icons.add_shopping_cart))
                          : Container()
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
