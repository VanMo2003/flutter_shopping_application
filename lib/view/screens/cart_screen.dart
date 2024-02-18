import 'package:flutter/material.dart';
import 'package:shopping_application/models/cart_model.dart';
import 'package:shopping_application/services/firebase/cart_firebase_service.dart';
import 'package:shopping_application/values/color_value.dart';
import 'package:shopping_application/values/text_style_value.dart';

import '../../values/asset_value.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartFirebaseService? _firebaseService;
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    _firebaseService = CartFirebaseService(email: args);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: StreamBuilder(
        stream: _firebaseService?.getCartAll(),
        builder: (context, snapshot) {
          List carts = snapshot.data?.docs ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (carts.isEmpty) {
            return const Center(
              child: Text(
                'List Product Empty',
                style: TextStyleValue.h4,
              ),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: carts.length,
            itemBuilder: (context, index) {
              CartModel cartModel = carts[index].data();
              String cartId = carts[index].id;

              return SingleChildScrollView(
                physics: const PageScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: controller,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      animateScroll(0.0);
                    });
                  },
                  child: Container(
                    width: size.width + 80,
                    color: Colors.grey,
                    child: Padding(
                      padding: index == carts.length - 1
                          ? const EdgeInsets.only(top: 2.0, bottom: 2.0)
                          : const EdgeInsets.only(top: 2.0),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.125 - 2,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              height: size.height * 0.12 - 16,
                              width: size.height * 0.12 - 16,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    cartModel.image,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: size.height * 0.12 - 16,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 12,
                                      child: Text(
                                        cartModel.nameProduct,
                                        style: TextStyleValue.h4,
                                      ),
                                    ),
                                    Positioned(
                                      top: 25,
                                      left: 12,
                                      child: Text(
                                        'Clothes',
                                        style: TextStyleValue.h4.copyWith(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 12,
                                      child: Text(
                                        '\$${cartModel.unitPrice}',
                                        style: TextStyleValue.h4.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 80,
                                      child: SizedBox(
                                        height: 30,
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                CartModel cartModelNew =
                                                    cartModel.copyWith(
                                                  quantity:
                                                      cartModel.quantity > 1
                                                          ? --cartModel.quantity
                                                          : cartModel.quantity,
                                                );
                                                _firebaseService?.updateToCart(
                                                  cartId,
                                                  cartModelNew,
                                                );
                                                // setState(() {
                                                //   if (cartModel.quantity > 1) {
                                                //     cartModel.quantity--;
                                                //   }
                                                // });
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Image.asset(
                                                  AssetValue.less_icon,
                                                  scale: 0.8,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${cartModel.quantity}',
                                              style: TextStyleValue.h4.copyWith(
                                                fontSize: 20,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                CartModel cartModelNew =
                                                    cartModel.copyWith(
                                                  quantity:
                                                      ++cartModel.quantity,
                                                );
                                                _firebaseService?.updateToCart(
                                                  cartId,
                                                  cartModelNew,
                                                );
                                                // setState(() {
                                                //   cartModel.quantity++;
                                                // });
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey.shade300,
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
                                    Positioned(
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: () {
                                          deleteProduct(cartId);
                                        },
                                        child: Container(
                                          height: size.height * 0.125 - 2,
                                          width: 64,
                                          color: ColorValue.backgroundColor,
                                          child: Center(
                                            child: Image.asset(
                                              AssetValue.delete_icon,
                                              scale: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void deleteProduct(String cartId) async {
    debugPrint('delete');
    _firebaseService?.deleteToCart(cartId);
    setState(() {
      animateScroll(0.0);
    });
  }

  Future<void> animateScroll(double offset) async {
    await controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }
}
