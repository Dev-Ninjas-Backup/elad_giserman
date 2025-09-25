import 'package:elad_giserman/core/utils/constants/image_path.dart';
import 'package:get/get.dart';

class Place {
  final String image;
  final String title;
  final String subTitle;
  final double rating;
  final int reviewNum;
  final String category;
  bool isFavorite;

  Place({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.rating,
    required this.reviewNum,
    required this.category,
    this.isFavorite = false,
  });
}

class Recommended {
  final String image;
  final String title;
  final String description;
  final String location;
  bool isFavorite;

  Recommended({
    required this.image,
    required this.title,
    required this.description,
    required this.location,
    this.isFavorite = false,
  });
}

class HomeController extends GetxController {
  var restaurants = <Place>[].obs;
  var recommended = <Recommended>[].obs;

  @override
  void onInit() {
    super.onInit();
    restaurants.value = [
      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Rothschild Blvd 22, Tel Aviv, Israel",
        rating: 4.9,
        reviewNum: 327,
        category: "Restaurant",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.7,
        reviewNum: 210,
        category: "Bar",
      ),
      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.5,
        reviewNum: 210,
        category: "Cafe",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.8,
        reviewNum: 210,
        category: "Bar",
      ),

      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Rothschild Blvd 22, Tel Aviv, Israel",
        rating: 4.9,
        reviewNum: 327,
        category: "Restaurant",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.7,
        reviewNum: 210,
        category: "Bar",
      ),
      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.5,
        reviewNum: 210,
        category: "Cafe",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.8,
        reviewNum: 210,
        category: "Bar",
      ),

      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Rothschild Blvd 22, Tel Aviv, Israel",
        rating: 4.9,
        reviewNum: 327,
        category: "Restaurant",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.7,
        reviewNum: 210,
        category: "Bar",
      ),
      Place(
        image: ImagePath.popularRestaurant1,
        title: "Olive & Thyme Mediterranean Kitchen",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.5,
        reviewNum: 210,
        category: "Cafe",
      ),
      Place(
        image: ImagePath.popularRestaurant2,
        title: "Café Europa",
        subTitle: "Ben Yehuda St 99, Tel Aviv, Israel",
        rating: 4.8,
        reviewNum: 210,
        category: "Bar",
      ),
    ];

    recommended.value = [
      Recommended(
        image: ImagePath.recommended1,
        title: 'Gatsby Vintage Cocktail Room & Lounge',
        description:
            'A renowned venue for live music, Zappa hosts both local and international acts in a vibrant, energetic environment. Ideal for concerts, music lovers, and late-night entertainment.',
        location: 'Rothschild Blvd 22, Tel Aviv, Israel',
      ),
      Recommended(
        image: ImagePath.recommended2,
        title: 'Mamilla Hotel Rooftop Lounge',
        description:
            'A renowned venue for live music, Zappa hosts both local and international acts in a vibrant, energetic environment. Ideal for concerts, music lovers, and late-night entertainment.',
        location: 'Rothschild Blvd 22, Tel Aviv, Israel',
      ),
      Recommended(
        image: ImagePath.recommended3,
        title: 'The Little Prince Bookstore Café',
        description:
            'A renowned venue for live music, Zappa hosts both local and international acts in a vibrant, energetic environment. Ideal for concerts, music lovers, and late-night entertainment.',
        location: 'Rothschild Blvd 22, Tel Aviv, Israel',
      ),
      Recommended(
        image: ImagePath.recommended1,
        title: 'The Vibe Bar',
        description:
            'A renowned venue for live music, Zappa hosts both local and international acts in a vibrant, energetic environment. Ideal for concerts, music lovers, and late-night entertainment.',
        location: 'Rothschild Blvd 22, Tel Aviv, Israel',
      ),
    ];
  }

  void toggleFavorite(int index) {
    restaurants[index].isFavorite = !restaurants[index].isFavorite;
    restaurants.refresh();
  }

  void toggleRecommendedFavorite(int index) {
    if (index < 0 || index >= recommended.length) return;
    recommended[index].isFavorite = !recommended[index].isFavorite;
    recommended.refresh();
  }
}
