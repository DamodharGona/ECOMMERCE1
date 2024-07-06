import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{
      final List<String> _cartItems = [];
      List<String> get cartItems => _cartItems;
      void addToCart(String item){
          _cartItems.add(item);
          notifyListeners();
      }
      void removeCartItem(String item){
        _cartItems.remove(item);
        notifyListeners();
      }
}