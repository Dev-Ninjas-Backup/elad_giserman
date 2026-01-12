class Urls {
  static const String baseUrl = 'http://31.97.125.159:5050/api';

  static const String register = '$baseUrl/auth/register';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String resendOtp = '$baseUrl/auth/resend-otp';
  static const String login = '$baseUrl/auth/login';
  static const String googleLogin = '$baseUrl/auth/google-login';
  static const String logout = '$baseUrl/auth/logout';
  static const String forgetPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String changePassword = '$baseUrl/auth/change-password';
  static const String myProfile = '$baseUrl/user-info/my-profile';
  static const String updateProfile = '$baseUrl/user-info';
  static const String spinHistory = '$baseUrl/user-info/spin-history';
  static const String mySpinHistory =
      'https://api.yamiz.org/api/user-info/my-spin-history';
  static const String deleteAccount = '$baseUrl/user-info/delete-my-account';
  static const String categories = '$baseUrl/category/all';
  static const String businessProfiles = '$baseUrl/business-profiles/profile';
  static const String postReview = '$baseUrl/review';
  static const String replyReview = '$baseUrl/review/reply';
  static const String addFavorite = '$baseUrl/user-favorite';
  static const String myFavorites = '$baseUrl/user-favorite/my-favorite';
  static const String userReservation = '$baseUrl/user-reservation';
  static const String markNotificationsAsRead =
      '$baseUrl/user-info/mark-as-read';
  static const String adminOffers = '$baseUrl/admin/offers';
  static const String adminActivity = '$baseUrl/admin/get-admin-activity';
}
