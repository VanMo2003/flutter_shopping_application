import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_application/models/cart_model.dart';
import 'package:shopping_application/models/product_model.dart';
import 'package:shopping_application/services/firebase/cart_firebase_service.dart';
import 'package:shopping_application/values/asset_value.dart';
import 'package:shopping_application/values/color_value.dart';
import 'package:shopping_application/values/text_style_value.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen(
      {super.key, required this.email, required this.productModel});
  final String email;
  final ProductModel productModel;
  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  Uint8List? image;
  int quantity = 1;
  bool isAddingProduct = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _image(),
          _header(),
          Positioned(
            top: size.height * 0.55,
            child: _content(),
          ),
          if (isAddingProduct) ...[
            Container(
              height: size.height,
              width: size.width,
              color: Colors.white.withOpacity(0.2),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget _content() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.45,
      width: size.width,
      decoration: const BoxDecoration(
        color: Color(0xffEBF1F1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.productModel.title}',
              style: TextStyleValue.h3,
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Text(
              'Clothes',
              style: TextStyleValue.h3.copyWith(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: const Color(0xffBEC3C7),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.productModel.price}',
              style: TextStyleValue.h3.copyWith(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.productModel.description}',
              style: TextStyleValue.h4.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 2,
            ),
            const Spacer(),
            SizedBox(
              width: size.width,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: size.width * 0.35,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                child: Image.asset(
                                  AssetValue.less_icon,
                                  scale: 0.8,
                                ),
                              ),
                            ),
                            Text(
                              '$quantity',
                              style: TextStyleValue.h4.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                child: Image.asset(
                                  AssetValue.add_icon,
                                  scale: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 8.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          addProductToCart();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorValue.primaryColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Center(
                            child: Text(
                              'Add to cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "Details Product",
              style: TextStyleValue.h3.copyWith(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.list,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.55 + 28,
          decoration: const BoxDecoration(
            color: ColorValue.backgroundColor,
          ),
          child: widget.productModel.images == null
              ? const Center(
                  child: Icon(
                    Icons.image,
                    size: 100,
                  ),
                )
              : Image.network(
                  '${widget.productModel.images![0]}',
                  fit: BoxFit.cover,
                ),
        )
      ],
    );
  }

  void addProductToCart() async {
    final CartFirebaseService firebaseService =
        CartFirebaseService(email: widget.email);
    CartModel cartModel = CartModel(
      idProduct: widget.productModel.id!,
      image: widget.productModel.images![0],
      nameProduct: widget.productModel.title ?? '',
      unitPrice: widget.productModel.price ?? 0.0,
      quantity: quantity,
      createOn: Timestamp.now(),
      updateOn: Timestamp.now(),
    );
    setState(() {
      isAddingProduct = true;
    });
    await firebaseService.addDataToCart(cartModel);
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        setState(() {
          isAddingProduct = false;
        });
      },
    );
  }
}
