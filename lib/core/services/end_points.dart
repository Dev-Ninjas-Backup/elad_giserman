class Urls {
  static const String baseUrl =
      'https://elad-giserman-backend-1s7o.onrender.com/api';

  static const String register = '$baseUrl/auth/register';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String resendOtp = '$baseUrl/auth/resend-otp';
  static const String login = '$baseUrl/auth/login';
  static const String logout = '$baseUrl/auth/logout';
  static const String forgetPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String changePassword = '$baseUrl/auth/change-password';
  static const String myProfile = '$baseUrl/user-info/my-profile';
  static const String updateProfile = '$baseUrl/user-info';
  static const String spinHistory = '$baseUrl/user-info/spin-history';
  static const String categories = '$baseUrl/category/all';
  static const String businessProfiles = '$baseUrl/business-profiles/profile';
  static const String postReview = '$baseUrl/review';
  static const String replyReview = '$baseUrl/review/reply';
  static const String addFavorite = '$baseUrl/user-favorite';
  static const String myFavorites = '$baseUrl/user-favorite/my-favorite';
}
