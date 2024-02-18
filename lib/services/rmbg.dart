import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static Future<Uint8List> removeBgApi(String imageUrl) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.remove.bg/v1.0/removebg"),
    );
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();
    request.files.add(http.MultipartFile.fromBytes("image_file", bytes));
    request.headers.addAll({"X-API-Key": "gS1voUMU7VWSE1qU272ypdoq"});
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}
