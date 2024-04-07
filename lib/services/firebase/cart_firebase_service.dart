// ignore_for_file: constant_identifier_names, void_checks
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/cart_model.dart';

const String USER_COLLECTION_REF = "users_shop";
const String CART_COLLECTION_REF = "carts_user";

class CartFirebaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _cartRef;
  String email;
  CartFirebaseService({required this.email}) {
    _cartRef = _firestore
        .collection(USER_COLLECTION_REF)
        .doc(email)
        .collection(CART_COLLECTION_REF)
        .withConverter<Cart>(
          fromFirestore: (snapshot, options) => Cart.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getCartAll() {
    return _cartRef.snapshots().first.then((value) => value.docs);
  }

  Future<void> addDataToCart(Cart cartModelNew) async {
    bool check = false;
    QuerySnapshot querySnapshot = await _firestore
        .collection(USER_COLLECTION_REF)
        .doc(email)
        .collection(CART_COLLECTION_REF)
        .get();

    querySnapshot.docs.map(
      (e) {
        Cart cartModelOld = Cart.fromJson(e.data() as Map<String, Object?>);
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
      debugPrint('cartRef : ${_cartRef.path}');
      _cartRef.add(cartModelNew);
    }
  }

  void updateToCart(String cartId, Cart cartMode) {
    _cartRef.doc(cartId).update(cartMode.toJson());
  }

  void deleteToCart(String cartId) {
    _cartRef.doc(cartId).delete();
  }
}
