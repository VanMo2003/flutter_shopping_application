import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  int idProduct;
  String image;
  String nameProduct;
  double unitPrice;
  int quantity;
  Timestamp createOn;
  Timestamp updateOn;

  CartModel({
    required this.idProduct,
    required this.image,
    required this.nameProduct,
    required this.unitPrice,
    required this.quantity,
    required this.createOn,
    required this.updateOn,
  });

  CartModel.fromJson(Map<String, Object?> json)
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

  CartModel copyWith({
    int? idProduct,
    String? image,
    String? nameProduct,
    double? unitPrice,
    int? quantity,
    Timestamp? createOn,
    Timestamp? updateOn,
  }) {
    return CartModel(
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
