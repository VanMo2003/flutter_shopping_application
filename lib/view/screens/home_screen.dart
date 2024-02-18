import 'package:flutter/material.dart';
import 'package:shopping_application/models/product_model.dart';
import 'package:shopping_application/models/user_model.dart';
import 'package:shopping_application/view/screens/detail_product_screen.dart';
import '../../../services/product_service.dart';
import '../../../services/user_service.dart';
import 'package:shopping_application/values/asset_value.dart';
import 'package:shopping_application/values/color_value.dart';
import 'package:shopping_application/values/route_value.dart';
import 'package:shopping_application/values/text_style_value.dart';
import 'package:shopping_application/view/widgets/dropdown_widget.dart';
import 'package:shopping_application/view/widgets/text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<ProductModel>> productList;
  late Future<UserModel> userModel;
  String? accessToken;
  String? email;

  @override
  void initState() {
    super.initState();

    productList = ProductService.getAllProduct();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accessToken = ModalRoute.of(context)!.settings.arguments as String;
    userModel = UserService.getUserWithSession(accessToken);

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
                  const CategoriesDropDown(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FutureBuilder<List<ProductModel>>(
                  future: productList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
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
                                ProductModel productModel = ProductModel(
                                  id: snapshot.data![index].id,
                                  title: snapshot.data![index].title,
                                  description:
                                      snapshot.data![index].description,
                                  price: snapshot.data![index].price,
                                  images: snapshot.data![index].images,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProductScreen(
                                      email: '$email',
                                      productModel: productModel,
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
                                            '${snapshot.data![index].images?.first}.jpeg',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      width: size.width * 0.4,
                                      top: size.height * 0.18 + 5,
                                      left: 5,
                                      child: Text(
                                        snapshot.data![index].title ?? 'title',
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
                                        snapshot.data![index].description ??
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
                                        '\$${snapshot.data![index].price ?? '0.0'}',
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
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                )),
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
              child: FutureBuilder(
                future: userModel,
                builder: (context, snapshot) {
                  email = snapshot.data?.email;
                  return ListTile(
                    leading: GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: CircleAvatar(
                        radius: 24,
                        child: ClipOval(
                          child: snapshot.data?.avatar == null
                              ? const Icon(Icons.image)
                              : Image.network('${snapshot.data!.avatar}'),
                        ),
                      ),
                    ),
                    title: Text(
                      snapshot.data?.name ?? 'Username',
                      style: TextStyleValue.h3.copyWith(fontSize: 22),
                    ),
                    subtitle: Text(
                      snapshot.data?.email ?? 'example@mail.com',
                      style: TextStyleValue.h4
                          .copyWith(color: const Color(0xffBEC3C7)),
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
                                arguments: snapshot.data?.email,
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
          const Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFieldWidget(
                hintText: 'Search',
                isSearchField: true,
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
            child: FutureBuilder(
              future: userModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                        child: Image.network("${snapshot.data?.avatar}"),
                      ),
                    ),
                    Text(
                      snapshot.data?.name ?? 'Username',
                      style: TextStyleValue.h3.copyWith(fontSize: 22),
                    ),
                    Text(
                      snapshot.data?.email ?? 'example@mail.com',
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
