// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/features/home/home/model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse(Urls.categories),
        headers: {'Content-Type': 'application/json'},
      );

      print('📂 Get Categories API Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? [];

        final categories = data
            .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
            .toList();

        print('✅ Categories Fetched: ${categories.length} categories');
        return categories;
      } else {
        print('❌ Failed to fetch categories: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Get Categories Error: $e');
      return [];
    }
  }
}
