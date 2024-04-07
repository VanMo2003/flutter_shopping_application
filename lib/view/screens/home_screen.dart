import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../../controllers/product_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../values/asset_value.dart';
import '../../values/color_value.dart';
import '../../values/route_value.dart';
import '../../values/text_style_value.dart';
import '../widgets/text_field_widget.dart';
import 'detail_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? accessToken;
  String? email;

  @override
  Widget build(BuildContext context) {
    Momentum.controller<ProductController>(context).getAllProducts();
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              _header(),
              _homepage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homepage() {
    Size size = MediaQuery.of(context).size;
    final safePadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: size.height * 0.82 - safePadding,
      // color: Colors.blue,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyleValue.h3.copyWith(fontSize: 22),
                  ),
                  // const CategoriesDropDown(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MomentumBuilder(
                controllers: const [ProductController],
                builder: (context, snapshots) {
                  var products = snapshots<ProductModel>().products;
                  if (products == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (products.isEmpty) {
                    return Center(
                        child: Text(
                      "Không tìm thấy sản phẩm",
                      style: TextStyleValue.h4.copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ));
                  } else {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: size.height * 0.31,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index % 2 == 0
                              ? const EdgeInsets.only(left: 8)
                              : const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              Product product = Product(
                                id: products[index].id,
                                title: products[index].title,
                                description: products[index].description,
                                price: products[index].price,
                                images: products[index].images,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailProductScreen(
                                    email: '$email',
                                    product: product,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(
                                      2,
                                      2,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: size.height * 0.18,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorValue.backgroundColor,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          '${products[index].images?.first}.jpeg',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    width: size.width * 0.4,
                                    top: size.height * 0.18 + 5,
                                    left: 5,
                                    child: Text(
                                      products[index].title ?? 'title',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyleValue.h4.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    width: size.width * 0.5 - 20,
                                    top: size.height * 0.18 + 30,
                                    left: 5,
                                    child: Text(
                                      products[index].description ??
                                          'description',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyleValue.h4.copyWith(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Text(
                                      '\$${products[index].price ?? '0.0'}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyleValue.h4.copyWith(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: MomentumBuilder(
                controllers: const [UserController],
                builder: (context, snapshots) {
                  var user = snapshots<UserModel>().user!;
                  email = user.email;
                  return ListTile(
                    leading: GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: CircleAvatar(
                        radius: 24,
                        child: ClipOval(
                          child: user.avatar == null
                              ? const Icon(Icons.image)
                              : Image.network('${user.avatar}'),
                        ),
                      ),
                    ),
                    title: Text(
                      user.name ?? 'Username',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      user.email ?? 'example@mail.com',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18, color: const Color(0xffBEC3C7)),
                    ),
                    contentPadding: const EdgeInsets.only(right: 0, left: 10),
                    trailing: SizedBox(
                      height: double.infinity,
                      width: size.width * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteValue.routeNameToCart,
                                arguments: user.email,
                              );
                            },
                            child: Image.asset(
                              AssetValue.cart_icon,
                              scale: 1,
                            ),
                          ),
                          Image.asset(
                            AssetValue.setting_icon,
                            scale: 0.8,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFieldWidget(
                hintText: 'Search',
                isSearchField: true,
                onChanged: (newValue) {
                  if (newValue != null) {
                    Momentum.controller<ProductController>(context)
                        .searchProduct(newValue);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawer() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.3,
          width: size.width * 0.6,
          color: ColorValue.primaryColor,
          child: SafeArea(
            child: MomentumBuilder(
              controllers: const [UserController],
              builder: (context, snapshots) {
                var user = snapshots<UserModel>().user;

                if (user == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.network("${user.avatar}"),
                      ),
                    ),
                    Text(
                      user.name ?? 'Username',
                      style: TextStyleValue.h3.copyWith(fontSize: 22),
                    ),
                    Text(
                      user.email ?? 'example@mail.com',
                      style: TextStyleValue.h4
                          .copyWith(color: const Color(0xffBEC3C7)),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          height: size.height * 0.7,
          width: size.width * 0.6,
          color: Colors.white,
        ),
      ],
    );
  }
}
