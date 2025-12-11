import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/home/home/model/favorite_model.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  /// Add or remove a favorite
  Future<Favorite?> toggleFavorite(String restaurantId) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final body = jsonEncode({'restaurantId': restaurantId});

      final response = await http.post(
        Uri.parse(Urls.addFavorite),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('❤️ Toggle Favorite API Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final favoriteData = jsonResponse['favorite'];

        if (favoriteData != null) {
          final favorite = Favorite.fromJson(
            favoriteData as Map<String, dynamic>,
          );
          print('✅ Favorite Toggled Successfully');
          return favorite;
        }
      } else {
        print('❌ Failed to toggle favorite: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Toggle Favorite Error: $e');
    }
    return null;
  }

  /// Fetch all favorite restaurants
  Future<List<Favorite>> getMyFavorites() async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse(Urls.myFavorites),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('❤️ Get Favorites API Response:');
      print('Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'] as List;
        final favorites = data
            .map((item) => Favorite.fromJson(item as Map<String, dynamic>))
            .toList();
        print('✅ Favorites Fetched Successfully: ${favorites.length} items');
        return favorites;
      } else {
        print('❌ Failed to fetch favorites: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('❌ Get Favorites Error: $e');
      return [];
    }
  }

  /// Check if a restaurant is favorite
  bool isFavorite(String restaurantId, List<Favorite> favorites) {
    return favorites.any((fav) => fav.restaurantId == restaurantId);
  }
}
