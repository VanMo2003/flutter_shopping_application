import 'dart:convert';

import 'package:shopping_application/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static const String url = "https://api.escuelajs.co/api/v1/categories";

  static Future<List<CategoryModel>> getAllCategory() async {
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonData =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      List<CategoryModel> result = [];

      for (var element in jsonData) {
        CategoryModel categoryModel = CategoryModel(
          id: element['id'],
          name: element['name'],
        );
        result.add(categoryModel);
      }
      return result;
    } else {
      throw Exception('Failed to load product');
    }
  }
}
