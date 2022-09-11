import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_tutorial_shop/model/Product.dart';
import 'package:http/http.dart' as http;

class DataClass with ChangeNotifier {
  //is it the same to extend or use with?

  int _count = 0;

  // final List<Product> _products = [];

//https://fakestoreapi.com/products
  int get getCount => _count;

  void incrementX() {
    _count++;
    print(_count);
    notifyListeners();
  }

  void subtract() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class ShopProvider extends ChangeNotifier {
  final String _productsUrl = "https://fakestoreapi.com/products";
  bool _isLoadingProducts = false;
  List<Product> _products = [];
  List<Product> _cartItems = [];

  bool get isLoadingProducts => _isLoadingProducts;

  List<Product> get cartItems => _cartItems;

  List<Product> get products => _products;

  //add to cart
  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeCartItem(Product product) {
    cartItems.remove(product);
    notifyListeners();
  }

  void getProducts() {
    //todo get all the products in here
  }

  getProduct(int id) {
    //get one product here
    return null;
    // return _products.map((e) => e.id == id.toString()).
  }

  void fetchProducts() async {
    _isLoadingProducts = true;
    print("getting products");
    try {
      final response = await http.get(Uri.parse(_productsUrl));
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        _products =
            List<Product>.from(l.map((product) => Product.fromJson(product)));
        _isLoadingProducts = false;
        notifyListeners();
      } else {
        _isLoadingProducts = false;
        throw Exception('Failed to load json');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
