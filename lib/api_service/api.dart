import 'dart:convert';

import 'package:dapur/models/product_items.dart';
import 'package:http/http.dart' as http;

var baseUrl = "ranting.twisdev.com";

Future<List<ProductItems>> getProduct() async {
  final response = await http.post(Uri.https(
      baseUrl, "index.php/rest/items/search/api_key/teampsisthebest/"));
  if (response.statusCode == 200) {
    final respponseData = jsonDecode(response.body);
    return (respponseData as List)
        .map((e) => ProductItems.fromJson(e))
        .toList();
  } else {
    throw Exception("Failed to Load data");
  }
}
