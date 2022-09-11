import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorial_shop/model/Product.dart';
import 'package:provider_tutorial_shop/util/data_class.dart';

class ProductGridItem extends StatefulWidget {
  final Product product;
  final bool isCart;

  const ProductGridItem({Key? key, required this.product, required this.isCart})
      : super(key: key);

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  @override
  Widget build(BuildContext context) {
    var shopActions = Provider.of<ShopProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Material(
        elevation: 20,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.,
          children: [
            SizedBox(
              height: 120,
              child: Image.network("${widget.product.image}"),
            ),
            // Spacer(),
            SizedBox(
                width: 200,
                height: 20,
                child: Text(
                  "${widget.product.title}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.product.price}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20,color: Colors.red),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                      !widget.isCart
                          ? GestureDetector(
                              onTap: () {
                                shopActions.addToCart(widget.product);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.add_shopping_cart),
                              ))
                          : GestureDetector(
                          onTap: () {
                            shopActions.removeCartItem(widget.product);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.delete_forever),
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
