import 'package:sylph/app/env.dart';

class AppConstants {
  static const String appName = Environments.appName;

  static const String defaultCurrencySymbol = '\₩';
  static const String defaultCurrencySide = 'right';

  static const String getHomeData = '';
  static int userLogin = 0;
  static String defaultSMSGateway='1'; // 2 = firebase , 1 = rest

  // getBanners.json?key=f598e9a0

  static const String getBannerList = 'getBannerList.json?key=f598e9a0&__method=POST';
  static const String getCategoryList = 'getCategoryList.json?key=f598e9a0';
  static const String getFrelancerList = 'getFrelancerList.json?key=f598e9a0';
  static const String getProductList = 'getProductList.json?key=f598e9a0';

  static const String getAllCategories = 'getCategoryList.json?key=f598e9a0';
  static const String getFreelancerFromCategory = 'getFreelancerFromCategory.json?key=f598e9a0&__method=POST';
  static const String getFreelancerByID = 'getFreelancerByID.json?key=f598e9a0&__method=POST';
  static const String myFavList = 'myFavList.json?key=f598e9a0&__method=POST';
  static const String getAllFreellancerReviews = 'getAllFreelancerReviews.json?key=f598e9a0&__method=POST';
  static const String removeFromFavList = 'getAllFreelancerReviews.json?key=f598e9a0&__method=POST';

  static const String getMyAppointments = 'getMyAppointments.json?key=f598e9a0&__method=POST';
  static const String getMyAppointmentsById = 'getMyAppointmentsById.json?key=f598e9a0&__method=POST';

  static const String updateAppointmentStatus  = 'updateAppointmentStatus.json?key=f598e9a0&__method=POST';
  static const String getFreelacerReviews = 'getFreelacerReviews.json?key=f598e9a0&__method=POST';
  static const String getAllProductCategories = 'getAllProductCategories.json?key=f598e9a0';
  static const String productSubCategoryByCate = 'productSubCategoryByCate.json?key=f598e9a0&__method=POST';
  static const String getProductByCateandSubCate = 'getProductByCateandSubCate.json?key=f598e9a0&__method=POST';
  static const String getProductInfo = 'getProductInfo.json?key=f598e9a0&__method=POST';

  static const String login = 'registUserInfo.json?key=f598e9a0&__method=POST';

}