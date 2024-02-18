import 'dart:convert';

import 'package:shopping_application/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String url = "http://10.0.2.2:8080/api/v1/products";

  static Future<List<ProductModel>> getAllProduct() async {
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonData =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      List<ProductModel> result = [];

      for (var element in jsonData) {
        ProductModel productModel = ProductModel(
          id: element['id'],
          title: element['title'],
          description: element['description'],
          price: double.parse(element['price'].toString()),
          images: element['images'],
        );
        result.add(productModel);
      }
      return result;
    } else {
      throw Exception('Failed to load product');
    }
  }
}
