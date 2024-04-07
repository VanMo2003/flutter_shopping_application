import 'package:momentum/momentum.dart';

import '../models/product_model.dart';
import '../services/network/product_network.dart';

class ProductController extends MomentumController<ProductModel> {
  @override
  ProductModel init() {
    return ProductModel(this, products: null);
  }

  void getAllProducts() async {
    var products = await ProductNetwork.getAllProduct();
    model.update(products: products);
  }

  void searchProduct(String search) async {
    var products = await ProductNetwork.getAllProduct();
    List<Product> findProducts = [];

    for (var element in products) {
      if (element.title!.toLowerCase().contains(search.toLowerCase())) {
        findProducts.add(element);
      }
    }

    model.update(products: findProducts);
  }
}
