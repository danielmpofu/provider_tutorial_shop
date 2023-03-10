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
 late double screenHeight;
 late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
            Padding(
              padding: const EdgeInsets.only(top: 8,left: 2,right: 2),
              child: SizedBox(
                // height: screenWidth*0.3,
                child: Image.network("${widget.product.image}",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),




            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: screenWidth*0.31,
                              child: Text(
                                "${widget.product.title}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              )),

                          Text(
                            "\$${widget.product.price}",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 20,color: Colors.purple),
                          ),
                        ],
                      ),


                      !widget.isCart
                          ? GestureDetector(
                              onTap: () {
                                shopActions.addToCart(widget.product);
                              },
                              child:  Padding(
                                padding: EdgeInsets.all(0),
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.purple.shade200)
                                  ),
                                  child: const Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(Icons.shopping_cart, color: Colors.purple,),
                                  ),
                                )


                                ,
                              ))
                          : GestureDetector(
                          onTap: () {
                            shopActions.removeCartItem(widget.product);
                          },
                          child: Icon(Icons.delete_forever))
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
