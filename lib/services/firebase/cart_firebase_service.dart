// ignore_for_file: constant_identifier_names, void_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_application/models/cart_model.dart';

const String USER_COLLECTION_REF = "users";
const String CART_COLLECTION_REF = "carts";

class CartFirebaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _cartRef;
  String email;
  CartFirebaseService({required this.email}) {
    _cartRef = _firestore
        .collection(USER_COLLECTION_REF)
        .doc(email)
        .collection(CART_COLLECTION_REF)
        .withConverter<CartModel>(
          fromFirestore: (snapshot, options) =>
              CartModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Stream<QuerySnapshot> getCartAll() {
    return _cartRef.snapshots();
  }

  Future<void> addDataToCart(CartModel cartModelNew) async {
    bool check = false;
    QuerySnapshot querySnapshot = await _firestore
        .collection(USER_COLLECTION_REF)
        .doc(email)
        .collection(CART_COLLECTION_REF)
        .get();

    querySnapshot.docs.map(
      (e) {
        CartModel cartModelOld =
            CartModel.fromJson(e.data() as Map<String, Object?>);
        String cartId = e.id;
        // deleteToCart(cartId);
        if (cartModelOld.idProduct == cartModelNew.idProduct) {
          check = true;
          int quantityOld = cartModelOld.quantity;
          int quantityAdd = cartModelNew.quantity;
          updateToCart(
            cartId,
            cartModelOld.copyWith(quantity: quantityOld + quantityAdd),
          );
        }
      },
    ).toList();
    if (!check) {
      _cartRef.add(cartModelNew);
    }
  }

  void updateToCart(String cartId, CartModel cartMode) {
    _cartRef.doc(cartId).update(cartMode.toJson());
  }

  void deleteToCart(String cartId) {
    _cartRef.doc(cartId).delete();
  }
}
