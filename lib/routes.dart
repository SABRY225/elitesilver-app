import 'package:customer/view/screen/LanguageScreen.dart';
import 'package:customer/view/screen/categoryProducts_screen.dart';
import 'package:customer/view/screen/checkoutInvestment_screen.dart';
import 'package:customer/view/screen/checkout_screen.dart';
import 'package:customer/view/screen/custom_order_screen.dart';
import 'package:customer/view/screen/search_screen.dart';
import 'package:customer/view/screen/settingsLanguageScreen.dart';
import 'package:flutter/material.dart';
import 'view/screen/home_screen.dart';
import 'view/screen/cart_screen.dart';
import 'view/screen/profile_screen.dart';
import 'view/screen/auth/login_screen.dart';
import 'view/screen/orders_screen.dart';
import 'view/screen/auth/otp_screen.dart';
import 'view/screen/auth/signup_screen.dart';
import 'view/screen/favorite_screen.dart';
import 'view/screen/product_details_screen.dart';


class AppRoutes {
  static const String login = "/login";
  static const String home = "/home";
  static const String cart = "/cart";
  static const String checkout = "/checkout";
  static const String orders = "/orders";
  static const String profile = "/profile";
  static const String otp = "/otp";
  static const String saved = "/saved";
  static const String signUp = "/sign-up";
  static const String productDetails = "/product-details";
  static const String language = "/language";
  static const String investmentCheckout = "/investment-checkout";
  static const String categoryProducts = "/category";
  static const String search = "/search";
  static const String selectLanguage = "/select-language";
  static const String customOrder = "/custom-order";

  static Map<String, Widget Function(BuildContext)> routes = {
    login: (context) => const LoginScreen(),
    productDetails: (context) => const ProductDetails(),
    home: (context) => const HomeScreen(),
    orders: (context) => const OrdersScreen(),
    cart: (context) =>  CartScreen(),
    profile: (context) => const ProfileScreen(),
    otp: (context) => const OtpScreen(),
    saved: (context) => const FavoriteScreen(),
    signUp: (context) => const SignupScreen(),
    language: (context) => const LanguageScreen(),
    search: (context) => const SearchScreen(),
    checkout: (context) => const CheckoutScreen(),
    investmentCheckout: (context) => const CheckoutInvestmentPage(),
    categoryProducts: (context) => const CategoryProductsPage(),
    selectLanguage: (context) => const SettingsLanguageScreen(),
    customOrder: (context) => const CustomOrderScreen(),
  };
}