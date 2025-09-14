import 'package:get/get.dart';

class TwistController extends GetxController {
  final selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  final RxList<Map<String, dynamic>> restaurants = <Map<String, dynamic>>[
    {
      "image": "assets/images/recommended1.png",
      "title": "Authentic Table Dining",
      "location": "Jaffa St 35, Jerusalem, Israel",
      "category": "Restaurant",
      "rating": 4.9,
      "reviewNum": 327,
      "isFavorite": true,
    },
    {
      "image": "assets/images/recommended2.png",
      "title": "Italian Pasta House",
      "location": "Herzl St 10, Tel Aviv, Israel",
      "category": "Restaurant",
      "rating": 4.7,
      "reviewNum": 210,
      "isFavorite": false,
    },
  ].obs;

  final RxList<Map<String, dynamic>> cafes = <Map<String, dynamic>>[
    {
      "image": "assets/images/recommended2.png",
      "title": "Coffee & Chill Spot",
      "location": "King George St, Jerusalem, Israel",
      "category": "Cafe",
      "rating": 4.7,
      "reviewNum": 210,
      "isFavorite": false,
    },
    {
      "image": "assets/images/recommended3.png",
      "title": "Downtown Coffee Roasters",
      "location": "Allenby St 12, Tel Aviv, Israel",
      "category": "Cafe",
      "rating": 4.8,
      "reviewNum": 145,
      "isFavorite": true,
    },
  ].obs;

  final RxList<Map<String, dynamic>> bars = <Map<String, dynamic>>[
    {
      "image": "assets/images/recommended3.png",
      "title": "Classic Wine Bar",
      "location": "Ben Yehuda St, Jerusalem, Israel",
      "category": "Bar",
      "rating": 4.8,
      "reviewNum": 145,
      "isFavorite": false,
    },
    {
      "image": "assets/images/recommended1.png",
      "title": "Nightlife Lounge",
      "location": "Dizengoff St 99, Tel Aviv, Israel",
      "category": "Bar",
      "rating": 4.6,
      "reviewNum": 200,
      "isFavorite": true,
    },
  ].obs;

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
