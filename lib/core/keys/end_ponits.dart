//? To define the end points of the APIs
class EndPoint {
  static const String baseUrl =
      "https://optikick-production-8c8c.up.railway.app/api/";
  static const String logIn = "login";
  static const String forgetPassword = "forgot-password";
  static const String verifyResetToken = "verify-reset-token";
  static const String resetPassword = "reset-password";
  static const String playerDash = 'player/dashboard';
  static const String doctorDash = "doctor/dashboard";
  static const String coachDash = "coach/dashboard";
  static const String doctorProfile = "doctor/profile";
  static const String coachProfile = "coach/profile";
  static const String playerProfile = "player/profile";
  static const String playerTrainingProgram = "player/training-program/current";
  static const String doctorListAllPlayers = "doctor/list-all-players";
  static const String coachListAllPlayers = "coach/list-all-players";
  static const String notification = "notifications";
  static const String playerMetrics = "player/metrics";
  static const String doctorsAssessment = "doctor/assessments";
  static const String approveAssessment = "/approve";
  static const String reschdule = "/reschedule";
  static const String requestAssessment = "player/assessments/request";
  static const String metricDetails = "player/metrics/details";
  static String notfiMarkAsRead(notificationID) {
    return "notifications/$notificationID/mark-as-read";
  }

  static String categorizeProducts = "products/category";
  static String addToCart = "carts";

  static String editProductEndPoint(id) {
    return "admin/products/$id";
  }

  static String deleteItemFromCart(int id) {
    return "carts/$id";
  }

  static String addToWishList(int id) {
    return "products/add-to-wish-list/$id";
  }

  static String deleteFromWishList(int id) {
    return "products/wish-list/$id";
  }

  static String getProductDetails(int id) {
    return "products/$id";
  }
}

//? To define the keys APIs
class ApiKey {
  static const String bearerToken = "288|T3wyhCMY3RKDQ6VL8zpld4W5QO39dl0Lktlb1Yy33aeb5284";
  static const String playerToken = "player_token";
  static const String identifier = "identifier";
  static const String password = "password";
  static const String confirmPassword = "password_confirmation";
  static const String status = "status";
  static const String message = "message";
  static const String data = "data";
  static const String user = "user";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String id = "id";
  static const String userId = "user_id";
  static const String loginId = "login_id";
  static const String token = "token";
  static const String role = "role";
  static const String dateOfBirth = "date_of_birth";
  static const String sex = "sex";
  static const String position = "position";
  static const String bloodType = "blood_type";
  static const String profile = "profile";
  static const String doctorRole = "doctor";
  static const String coachRole = "coach";
  static const String playerRole = "player";
  static const String isDoctor = "isDoctor";
  static const String isCoach = "isCoach";
  static const String isPlayer = "isPlayer";
  static const String email = "email";
  static const String forgetPassEmail = "forgetPassEmail";
//?

  static const String authorization = "Authorization";
  static const String stockQuantity = "stockQuantity";
  static const String file = "file";

  static const String productName = "productName";

  static const String content = "content";
  static const String number = "number";

  static const String totalElements = "totalElements";
  static const String totalPages = "totalPages";
  static const String first = "first";
  static const String last = "last";
  static const String page = "page";
  static const String fullName = "fullName";
  static const String profilePicture = "profilePicture";
  static const String available = "available";
  static const String favorite = "favorite";
}
