class AppLink {
  static const String server = "http://192.168.1.5:5000/api"; 
  static const String imagesStatic = "http://192.168.1.5:5000"; 

  static const String signUp = "$server/auth/register";
  static const String login  = "$server/auth/login";
  static const String verifyCode  = "$server/auth/verify-code";

  static const String products = "$server/products/view";

  static const String categories ="$server/categories";

  static const String cart ="$server/cart";
  static const String hippingCities ="$server/city/shipping-cities";
  static const String createOrder ="$server/orders/new";
  static const String createCustomOrder ="$server/custom/order";
  static const String orderSilver ="$server/orders/silver";
  static const String getOrders ="$server/orders/mobile";
  static const String getProducts ="$server/products/mobile";
  static const String getHome ="$server/home";
  static const String OrderAndPointByUser ="$server/home/orders-and-points";
  
  static const String favoriteView   = "$server/favorite/view";
  static const String favoriteAdd    = "$server/favorite/add";
  static const String favoriteRemove = "$server/favorite/delete";
  static const String favoriteToggle = "$server/favorite/toggle";
}

