import 'package:flutter/material.dart';
import 'package:provider_tutorial_shop/pages/cart_page.dart';
import 'package:provider_tutorial_shop/pages/second_page.dart';
import 'package:provider_tutorial_shop/util/data_class.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorial_shop/widgets/product_gridview.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    var shopActions = Provider.of<ShopProvider>(context, listen: false);

    return Consumer<ShopProvider>(builder: (context, shopProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title:  Text("Provider Shop"),
          actions: [
            !shopProvider.isLoadingProducts?
            Stack(
              children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const ShopCart();
                      }));
                    }),
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '${shopProvider.cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ):
            Transform.scale(
              scale: 0.4,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            )

          ],
        ),
        body: ProductsGridView(
          products: shopProvider.products,
          isCart: false,
        ),
      );
    });
  }
}
