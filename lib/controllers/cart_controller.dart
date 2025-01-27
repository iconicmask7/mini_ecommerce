import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class CartController extends StateNotifier<List<Product>> {
  CartController() : super([]);

  // Add product to cart or update quantity if it already exists
  void addToCart(Product product) {
    final existingProductIndex = state.indexWhere((item) => item.id == product.id);

    if (existingProductIndex != -1) {
      // Update the quantity of the existing product
      final updatedProduct = state[existingProductIndex].copyWith(
        quantity: state[existingProductIndex].quantity + 1,
      );

      state = [
        ...state.sublist(0, existingProductIndex),
        updatedProduct,
        ...state.sublist(existingProductIndex + 1),
      ];
    } else {
      // Add the product if it does not already exist in the cart
      state = [...state, product];
    }

    _saveCart();
  }

  // Remove product from cart and save the cart state
  void removeFromCart(Product product) {
    state = state.where((item) => item.id != product.id).toList();
    _saveCart();
  }

  // Adjust product quantity in cart and save the cart state
  void adjustQuantity(Product product, int quantity) {
    state = state.map((item) {
      return item.id == product.id ? product.copyWith(quantity: quantity) : item;
    }).toList();
    _saveCart();
  }

  // Save cart to local storage
  void _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }

  // Load cart from local storage
  void loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('cart')) {
      final cartJson = prefs.getString('cart');
      List cartList = jsonDecode(cartJson!);
      state = cartList.map((product) => Product.fromJson(product)).toList();
    }
  }
}


final cartProvider = StateNotifierProvider<CartController, List<Product>>((ref) {
  return CartController();
});