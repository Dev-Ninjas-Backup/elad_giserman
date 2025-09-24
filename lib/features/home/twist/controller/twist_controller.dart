import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:get/get.dart';

class TwistController extends GetxController {
  final selectedTab = 0.obs;
  final searchQuery = ''.obs;

  void changeTab(int index) {
    selectedTab.value = index;
    searchQuery.value = '';
  }

  final RxList<Map<String, dynamic>> restaurants = <Map<String, dynamic>>[
    {
      "image": ImagePath.restaurant1,
      "title": "Authentic Table Dining",
      "location": "Jaffa St 35, Jerusalem, Israel",
      "category": "Restaurant",
      "rating": 4.9,
      "reviewNum": 327,
      "isFavorite": true,
    },
    {
      "image": ImagePath.restaurant2,
      "title": "Olive & Thyme Mediterranean Kitchen",
      "location": "Rothschild Blvd 22, Tel Aviv, Israel",
      "category": "Restaurant",
      "rating": 4.7,
      "reviewNum": 210,
      "isFavorite": false,
    },
    {
      "image": ImagePath.restaurant3,
      "title": "Café Aroma Espresso & Bakery House",
      "location": "Carmel Center, Haifa, Israel",
      "category": "Restaurant",
      "rating": 4.3,
      "reviewNum": 270,
      "isFavorite": false,
    },
    {
      "image": ImagePath.restaurant4,
      "title": "Spicehaus – The Fantasy Cocktail Bar",
      "location": "Dizengoff St 117, Tel Aviv, Israel",
      "category": "Restaurant",
      "rating": 4.7,
      "reviewNum": 210,
      "isFavorite": true,
    },
  ].obs;

  final RxList<Map<String, dynamic>> cafes = <Map<String, dynamic>>[
    {
      "image": ImagePath.restaurant2,
      "title": "Café Aroma Espresso & Bakery House",
      "location": "Carmel Center, Haifa, Israel",
      "category": "Cafe",
      "rating": 4.7,
      "reviewNum": 210,
      "isFavorite": false,
    },
    {
      "image": ImagePath.restaurant2,
      "title": "The Little Prince Bookstore Café",
      "location": "Nahalat Binyamin St 19, Tel Aviv, Israel",
      "category": "Ca fe",
      "rating": 4.8,
      "reviewNum": 145,
      "isFavorite": true,
    },
  ].obs;

  final RxList<Map<String, dynamic>> bars = <Map<String, dynamic>>[
    {
      "image": ImagePath.restaurant4,
      "title": "Spicehaus – The Fantasy Cocktail Bar",
      "location": "Dizengoff St 117, Tel Aviv, Israel",
      "category": "Bar",
      "rating": 4.8,
      "reviewNum": 145,
      "isFavorite": false,
    },
    {
      "image": ImagePath.restaurant3,
      "title": "Gatsby Vintage Cocktail Room & Lounge",
      "location": "Hillel St 18, Jerusalem, Israel",
      "category": "Bar",
      "rating": 4.6,
      "reviewNum": 200,
      "isFavorite": true,
    },
  ].obs;

  List<Map<String, dynamic>> get filteredRestaurants {
    if (searchQuery.value.isEmpty) return restaurants;
    return restaurants.where((item) {
      final title = item['title'].toString().toLowerCase();
      final location = item['location'].toString().toLowerCase();
      final query = searchQuery.value.toLowerCase().trim();
      return title.contains(query) || location.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get filteredCafes {
    if (searchQuery.value.isEmpty) return cafes;
    return cafes.where((item) {
      final title = item['title'].toString().toLowerCase();
      final location = item['location'].toString().toLowerCase();
      final query = searchQuery.value.toLowerCase().trim();
      return title.contains(query) || location.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get filteredBars {
    if (searchQuery.value.isEmpty) return bars;
    return bars.where((item) {
      final title = item['title'].toString().toLowerCase();
      final location = item['location'].toString().toLowerCase();
      final query = searchQuery.value.toLowerCase().trim();
      return title.contains(query) || location.contains(query);
    }).toList();
  }

  void updateSearchQuery(String query) {
    // Validate: Only update if query is not just whitespace
    if (query.trim().isNotEmpty || query.isEmpty) {
      searchQuery.value = query;
    }
  }

  void toggleFavorite(int tabIndex, int itemIndex) {
    RxList<Map<String, dynamic>> list;
    if (tabIndex == 0) {
      list = restaurants;
    } else if (tabIndex == 1) {
      list = cafes;
    } else {
      list = bars;
    }

    if (itemIndex < 0 || itemIndex >= list.length) return;

    final current = Map<String, dynamic>.from(list[itemIndex]);
    final bool currentFav = (current['isFavorite'] ?? false) as bool;
    current['isFavorite'] = !currentFav;

    list[itemIndex] = current;
  }
}
