import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../models/cart_model.dart';
import '../services/firebase/cart_firebase_service.dart';

class CartController extends MomentumController<CartModel> {
  @override
  CartModel init() {
    return CartModel(this, carts: null, totalMoney: 0);
  }

  void getCart(String email) async {
    CartFirebaseService firebaseService = CartFirebaseService(email: email);

    var data = await firebaseService.getCartAll();

    if (data!.isNotEmpty) {
      model.update(carts: data);
      getTotalMoneyOfCart(data);
    } else {
      debugPrint('error : Không lấy được giỏ hàng');
    }
  }

  void getTotalMoneyOfCart(var data) {
    double totalMoneyOfCart = 0;
    for (var element in data) {
      Cart cartModel = element.data();

      totalMoneyOfCart += cartModel.unitPrice * cartModel.quantity;
      model.update(totalMoney: totalMoneyOfCart);
    }
  }

  void updateCart(String email, String cartId, Cart cartModelNew) {
    CartFirebaseService firebaseService = CartFirebaseService(email: email);

    firebaseService.updateToCart(
      cartId,
      cartModelNew,
    );

    getCart(email);
  }

  void deleteProduct(String email, String cartId) async {
    CartFirebaseService firebaseService = CartFirebaseService(email: email);

    firebaseService.deleteToCart(cartId);
    getCart(email);
  }
}
