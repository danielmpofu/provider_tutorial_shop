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
  late ShopProvider shopActions;

  late double screenHeight;
  late double screenWidth;
  late var kHeadingTextStyle = TextStyle(
      fontSize: screenHeight * 0.030,
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    shopActions = Provider.of<ShopProvider>(context, listen: false);

    return Consumer<ShopProvider>(builder: (context, shopProvider, child) {
      return SafeArea(
        child: Scaffold(
            body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.menu),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: borderedIcon(
                    appBarIcon(shopProvider),
                  ),
                )
              ],
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Collections",
                      style: kHeadingTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TopSearchBar(cartIcon: Container()),
                    ),
                    horizontalCategoriesList(),


                    Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("New In.",
                              style: kHeadingTextStyle),
                          borderedIcon(
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: const [
                                    Text("Sort", style: TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.sort_outlined),
                                    ),
                                  ],
                                ),
                              )

                          )
                        ],
                      ),
                    ),

                    ProductsGridView(
                      products: shopProvider.products,
                      isCart: false,
                    )
                  ],
                ),
              ),
            ),



            // SliverToBoxAdapter(
            //   child: ProductsGridView(
            //     products: shopProvider.products,
            //     isCart: false,
            //   ),
            // )
          ],
        )),
      );
    });
  }

  Widget borderedIcon(Widget icon) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.purple.shade200)),
            child: Padding(padding: const EdgeInsets.all(0), child: icon)));
  }

  Widget appBarIcon(shopProvider) {
    return !shopProvider.isLoadingProducts
        ? Stack(
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.shopping_cart,
                      size: 35, color: Colors.purple),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const ShopCart();
                    }));
                  }),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '${shopProvider.cartItems.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          )
        : Transform.scale(
            scale: 0.4,
            child: const CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
  }

  Widget horizontalCategoriesList() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: screenHeight * 0.16,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: images,
        ));
  }

  Widget horizontalCategoryListItem(name, imgUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(40), // Image radius
              child: Image.network(imgUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  late List<Widget> images = [
    Padding(
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          width: screenWidth * 0.25,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 28, left: 10),
            child: Material(
                color: Colors.purple.shade400,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.purple.shade200)),
                child: const Padding(
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.category,
                      color: Colors.white,
                      size: 60,
                    ))),
          ),
        )),
    horizontalCategoryListItem("Women",
        "https://images.unsplash.com/photo-1609538988899-df2205467145?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1020&q=80"),
    horizontalCategoryListItem("Sports",
        "https://images.unsplash.com/photo-1618517048289-4646902edaf5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
    horizontalCategoryListItem("Men",
        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
    horizontalCategoryListItem("Girls",
        "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
    horizontalCategoryListItem("Hats",
        "https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80"),
    horizontalCategoryListItem("Outdoor",
        "https://images.unsplash.com/photo-1492446845049-9c50cc313f00?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
    horizontalCategoryListItem("Summer",
        "https://images.unsplash.com/photo-1522556189639-b150ed9c4330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"),
    horizontalCategoryListItem("Colorful",
        "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1020&q=80"),
  ];
}

class CategResource {
  late String name, url;
}

class TopSearchBar extends StatefulWidget {
  final Widget cartIcon;

  const TopSearchBar({Key? key, required this.cartIcon}) : super(key: key);

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              label: Text("Search .."),
              labelStyle: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        widget.cartIcon
      ],
    );
  }
}
