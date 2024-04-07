import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../../controllers/cart_controller.dart';
import '../../models/cart_model.dart';
import '../../values/asset_value.dart';
import '../../values/color_value.dart';
import '../../values/text_style_value.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    Momentum.controller<CartController>(context).getCart(email);
    return Scaffold(
      appBar: appBar,
      body: _body(),
    );
  }

  AppBar appBar = AppBar(
    title: const Text("Cart"),
    centerTitle: true,
  );

  Widget _body() {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: SizedBox(
            width: size.width,
            child: MomentumBuilder(
              controllers: const [CartController],
              builder: (context, snapshot) {
                List? carts = snapshot<CartModel>().carts;
                if (carts == null) {
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
                    Cart cartModel = carts[index].data();
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Cart cartModelNew =
                                                          cartModel.copyWith(
                                                        quantity:
                                                            cartModel.quantity >
                                                                    1
                                                                ? --cartModel
                                                                    .quantity
                                                                : cartModel
                                                                    .quantity,
                                                      );
                                                      Momentum.controller<
                                                                  CartController>(
                                                              context)
                                                          .updateCart(
                                                        email,
                                                        cartId,
                                                        cartModelNew,
                                                      );
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Image.asset(
                                                        AssetValue.less_icon,
                                                        scale: 0.8,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${cartModel.quantity}',
                                                    style: TextStyleValue.h4
                                                        .copyWith(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Cart cartModelNew =
                                                          cartModel.copyWith(
                                                        quantity: ++cartModel
                                                            .quantity,
                                                      );
                                                      Momentum.controller<
                                                                  CartController>(
                                                              context)
                                                          .updateCart(
                                                        email,
                                                        cartId,
                                                        cartModelNew,
                                                      );
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
                                                // deleteProduct(cartId);
                                                Momentum.controller<
                                                        CartController>(context)
                                                    .deleteProduct(
                                                        email, cartId);
                                                animateScroll(0.0);
                                              },
                                              child: Container(
                                                height: size.height * 0.125 - 2,
                                                width: 64,
                                                color:
                                                    ColorValue.backgroundColor,
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
          ),
        ),
        // const Divider(
        //   height: 2,
        //   thickness: 2,
        // ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.only(right: 5),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MomentumBuilder(
                  controllers: const [CartController],
                  builder: (context, snapshot) {
                    var totalMoney = snapshot<CartModel>().totalMoney;
                    return Text(
                      "Tổng giỏ hàng : $totalMoney",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: ColorValue.primaryColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: Text(
                        'Thanh toán',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> animateScroll(double offset) async {
    await controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }
}
