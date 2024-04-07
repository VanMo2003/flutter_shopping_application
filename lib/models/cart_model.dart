import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momentum/momentum.dart';

import '../controllers/cart_controller.dart';

class CartModel extends MomentumModel<CartController> {
  final List<QueryDocumentSnapshot<Object?>>? carts;
  final double? totalMoney;

  const CartModel(CartController controller, {this.carts, this.totalMoney})
      : super(controller);

  @override
  void update(
      {List<QueryDocumentSnapshot<Object?>>? carts, double? totalMoney}) {
    CartModel(controller,
            carts: carts ?? this.carts,
            totalMoney: totalMoney ?? this.totalMoney)
        .updateMomentum();
  }
}

class Cart {
  int idProduct;
  String image;
  String nameProduct;
  double unitPrice;
  int quantity;
  Timestamp createOn;
  Timestamp updateOn;

  Cart({
    required this.idProduct,
    required this.image,
    required this.nameProduct,
    required this.unitPrice,
    required this.quantity,
    required this.createOn,
    required this.updateOn,
  });

  Cart.fromJson(Map<String, Object?> json)
      : this(
          idProduct: json['idProduct'] as int,
          image: json['image'] as String,
          nameProduct: json['nameProduct'] as String,
          unitPrice: json['unitPriceProduct'] as double,
          quantity: json['quantityProduct'] as int,
          createOn: json['createOn'] as Timestamp,
          updateOn: json['updateOn'] as Timestamp,
        );
  Map<String, Object?> toJson() {
    return {
      'idProduct': idProduct,
      'image': image,
      'nameProduct': nameProduct,
      'unitPriceProduct': unitPrice,
      'quantityProduct': quantity,
      'createOn': createOn,
      'updateOn': updateOn,
    };
  }

  Cart copyWith({
    int? idProduct,
    String? image,
    String? nameProduct,
    double? unitPrice,
    int? quantity,
    Timestamp? createOn,
    Timestamp? updateOn,
  }) {
    return Cart(
      idProduct: idProduct ?? this.idProduct,
      image: image ?? this.image,
      nameProduct: nameProduct ?? this.nameProduct,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      createOn: createOn ?? this.createOn,
      updateOn: updateOn ?? this.updateOn,
    );
  }
}

// class ListCartModel {
//   List<CartModel>? data;
//   ListCartModel({this.data});

//   ListCartModel.fromJson(Map<String, Object?> json)
//       : this(
//           data: json['data'] as List<CartModel>,
//         );
//   Map<String, Object?> toJson() {
//     return {
//       'data': data,
//     };
//   }
// }
