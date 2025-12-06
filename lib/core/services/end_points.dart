class Urls {
  static const String baseUrl = 'https://api.yamiz.org/api';

  static const String register = '$baseUrl/auth/register';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String resendOtp = '$baseUrl/auth/resend-otp';
  static const String login = '$baseUrl/auth/login';
  static const String forgetPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String changePassword = '$baseUrl/auth/change-password';
  static const String myProfile = '$baseUrl/user-info/my-profile';
  static const String updateProfile = '$baseUrl/user-info';
  static const String spinHistory = '$baseUrl/user-info/spin-history';
}
