import 'package:customer/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  Locale? initialLocale;
  
  // مفاتيح التخزين (Keys) لتجنب الأخطاء الإملائية
  static const String langKey = "lang";
  static const String tokenKey = "token";

  @override
  void onInit() {
    super.onInit();
    getSavedLocale();
  }

  // 1. تحديد اللغة الابتدائية عند تشغيل التطبيق
  void getSavedLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sharedPrefLang = prefs.getString(langKey);

    if (sharedPrefLang == "ar") {
      initialLocale = const Locale("ar");
    } else if (sharedPrefLang == "en") {
      initialLocale = const Locale("en");
    } else {
      // إذا لم يختار لغة بعد، نستخدم لغة الجهاز الافتراضية
      initialLocale = Locale(Get.deviceLocale!.languageCode);
    }
    update(); // تحديث الواجهة إذا لزم الأمر
  }

  // 2. دالة تغيير اللغة مع فحص حالة المستخدم (Auth Check)
  void changeLang(String langCode) async {
    Locale locale = Locale(langCode);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // حفظ اللغة المختارة
    await prefs.setString(langKey, langCode);
    
    // تحديث لغة التطبيق في الوقت الفعلي
    Get.updateLocale(locale);

    // فحص هل المستخدم مسجل دخول (وجود توكن)
    String? token = prefs.getString(tokenKey);

    if (token != null && token.isNotEmpty) {
      // إذا كان مسجل دخول -> الرئيسية
      Get.offAllNamed(AppRoutes.home);
    } else {
      // إذا لم يسجل دخول -> صفحة تسجيل الدخول
      Get.offAllNamed(AppRoutes.login);
    }
  }

  // 3. دالة لتحديد أول صفحة تظهر للمستخدم (تستخدم في main.dart)
  Future<String> checkInitialRoute() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String? lang = prefs.getString(langKey);
    String? token = prefs.getString(tokenKey);

    // إذا لم يختار لغة أبداً، اذهب لصفحة اللغة
    if (lang == null) {
      return AppRoutes.language;
    }

    // إذا اختار لغة، افحص هل هو مسجل دخول أم لا
    if (token != null && token.isNotEmpty) {
      return AppRoutes.home;
    } else {
      return AppRoutes.login;
    }
  }
}