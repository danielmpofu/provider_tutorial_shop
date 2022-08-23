// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorial_shop/pages/first_page.dart';
import 'package:provider_tutorial_shop/util/data_class.dart';

void main() {
  runApp(

      MultiProvider(

    providers: [
      ChangeNotifierProvider(create: (_) => DataClass()),
      ChangeNotifierProvider(create: (_)=>ShopProvider())
      // ChangeNotifierProvider(create: (_) => DataClass2())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<ShopProvider>(context, listen: false).fetchProducts();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}
