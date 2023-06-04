import 'dart:convert';
import 'package:e_commerse_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

class ProductService {
  static Future<List<Product>?> getProducts({int limit = 0}) async {
    try {
      var response = await http
          .get(Uri.parse(
              'https://fakestoreapi.com/products?limit=${limit.toString()}&sort=desc'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode != 200) return [];

      if (jsonDecode(response.body).isEmpty) {
        return [];
      } else {
        return List<Product>.from(
            jsonDecode(response.body).map((e) => Product.fromJson(e))).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Product>?> getCategoryProducts(
      {required String categoryTitle}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://fakestoreapi.com/products/category/${categoryTitle}'));

      if (response.statusCode != 200) return [];

      if (jsonDecode(response.body).isEmpty) {
        return [];
      } else {
        return List<Product>.from(
            jsonDecode(response.body).map((e) => Product.fromJson(e))).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<bool> sendCart(
      {required List<Map<String, String>> productSelected}) async {
    try {
      var response =
          await http.post(Uri.parse('https://fakestoreapi.com/carts'),
              body: jsonEncode({
                'userId': 5,
                'date': intl.DateFormat('yyyy-MM-dd').format(DateTime.now()),
                'products': productSelected,
              }));

      if (response.statusCode != 200) return false;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
