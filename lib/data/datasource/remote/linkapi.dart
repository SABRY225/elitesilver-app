class AppLink {
  // الرابط الأساسي للسيرفر
  static const String server = "http://192.168.1.5:5000/api"; 
static const String imagesStatic = "http://192.168.1.5:5000"; 

  // روابط المصادقة (Auth)
  static const String signUp = "$server/auth/signup";
  static const String login  = "$server/auth/login";

  // روابط المنتجات والمفضلة
  static const String products = "$server/products/view";

  static const String categories ="$server/categories";

  static const String cart ="$server/cart";
  static const String hippingCities ="$server/city/shipping-cities";
  static const String createOrder ="$server/orders/new";
  
  // الروابط التي ستحتاجها في الـ FavoriteController الجديد
  static const String favoriteView   = "$server/favorite/view";
  static const String favoriteAdd    = "$server/favorite/add";
  static const String favoriteRemove = "$server/favorite/delete";
  static const String favoriteToggle = "$server/favorite/toggle";
}

