class Urls {
  static const String baseUrl = 'http://46.202.179.186';
  static const String register = '/api/v1/auth/register';
  static const String login = '/api/v1/auth/login';
  static const String refreshAccessToken = '/api/v1/auth/refresh-access-token';
  // static const String updateAccessAndRefreshToken = '/api/v1/auth/refresh-access-token';
  static const String forgetPassword = '/api/v1/auth/forget-password';
  static const String resetPassword = '/api/v1/auth/reset-password';
  static const String verifyCode = '/api/v1/auth/verify-code';
  static const String logOut = '/api/v1/auth/logout';

  //commanders
  static const String createCommander = '/api/v1/commander';

  static const String getAllCommanders = '/api/v1/commander';

  //................................ If need to get filtered commanders
  // static const String getFilteredCommanders =
  //     '/api/v1/commander?page=1&limit=8&service=Army&unit=101st Division';

  static const String getSpecificCommanders = '/api/v1/commander/';

  //Services
  static const String getAllReviews = '/api/v1/review';
  //static const String getAllReviews = '/api/v1/review?page=1&limit=1';

  static const String createReview = '/api/v1/review';

  static const String getTopFiveReviews = '/api/v1/review/top-five';

  static const String getAllServices = '/api/v1/service';
  // static const String getAllServices = '/api/v1/service?page=1&limit=10';

  static const String getAllBlogs = '/api/v1/blog';
  //static const String getAllBlogs ='/api/v1/blog?page=1&limit=100&slug=first-blogsdaf';

  static const String getABlogs = '/api/v1/blog/';

  static const String getAllCategoryBlogs = '/api/v1/blog/blog-category';

  static const String getAllUnits = '/api/v1/unit';
  //static const String getAllUnits = '/api/v1/unit?page=1&limit=10';

  static const String getAllContact = '/api/v1/contact/';
  static const String getAllFeaturedReview = '/api/v1/review/featured-top-five';

  static const String commentUnderBlog = '/api/v1/blog/comment';
  //static const String getCommanderById = '/api/v1/commanders/';
}
