// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:elad_giserman/core/services/end_points.dart';
import 'package:elad_giserman/core/services/shared_preferences_helper.dart';
import 'package:elad_giserman/features/home/details/model/profile_detail_model.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  Future<Review?> postReview({
    required String comment,
    required int rating,
    required String businessProfileId,
  }) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final body = jsonEncode({
        'comment': comment,
        'rating': rating,
        'businessProfileId': businessProfileId,
      });

      final response = await http.post(
        Uri.parse(Urls.postReview),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('📝 Post Review API Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final reviewData = jsonResponse['data'];

        if (reviewData != null) {
          final review = Review.fromJson(reviewData as Map<String, dynamic>);
          print('✅ Review Posted Successfully');
          return review;
        }
      } else {
        print('❌ Failed to post review: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Post Review Error: $e');
    }
    return null;
  }

  Future<ReviewReply?> replyToReview({
    required String reviewId,
    required String comment,
  }) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final body = jsonEncode({'reviewId': reviewId, 'comment': comment});

      final response = await http.post(
        Uri.parse(Urls.replyReview),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('💬 Reply Review API Response:');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        // The API returns the reply data directly
        final replyData = jsonResponse is Map
            ? jsonResponse
            : jsonResponse['data'];

        if (replyData != null) {
          final reply = ReviewReply.fromJson(replyData as Map<String, dynamic>);
          print('✅ Review Reply Posted Successfully');
          return reply;
        }
      } else {
        print('❌ Failed to post review reply: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Reply Review Error: $e');
    }
    return null;
  }
}
