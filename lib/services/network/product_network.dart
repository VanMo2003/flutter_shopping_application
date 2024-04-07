import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/product_model.dart';

class ProductNetwork {
  static const String url = "http://10.0.2.2:8080/api/v1/products";

  static Future<List<Product>> getAllProduct() async {
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonData =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      List<Product> result = [];

      for (var element in jsonData) {
        Product product = Product(
          id: element['id'],
          title: element['title'],
          description: element['description'],
          price: double.parse(element['price'].toString()),
          images: element['images'],
        );
        result.add(product);
      }
      return result;
    } else {
      throw Exception('Failed to load product');
    }
  }
}
