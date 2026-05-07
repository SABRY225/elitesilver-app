import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/locale_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());

    return Scaffold(
      body: Stack(
        children: [
          // 1. خلفية متدرجة فخمة
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF000000), Color(0xFF1A1A1A), Color(0xFF000000)],
              ),
            ),
          ),
          // 2. دوائر ضوئية خافتة (Ambient Light) خلف المحتوى
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withOpacity(0.05),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // شعار مودرن بتأثير نيون خفيف
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange.withOpacity(0.5), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        )
                      ],
                    ),
                    child: const Icon(Icons.language_rounded, size: 70, color: Colors.orange),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  const Text(
                    "Select Language",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    "اختر اللغة المناسبة للتطبيق",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                    ),
                  ),
                  
                  const SizedBox(height: 60),

                  // زر اللغة العربية
                  _buildModernButton(
                    title: "العربية",
                    subtitle: "Arabic Language",
                    icon: "🇯🇴",
                    onPressed: () => controller.changeLang("ar"),
                  ),

                  const SizedBox(height: 20),

                  // زر اللغة الإنجليزية
                  _buildModernButton(
                    title: "English",
                    subtitle: "English Language",
                    icon: "🇺🇸",
                    onPressed: () => controller.changeLang("en"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت زر احترافي بتصميم "Card"
  Widget _buildModernButton({
    required String title,
    required String subtitle,
    required String icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF252525), // لون داكن مريح
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)), // حواف ناعمة جداً
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            // أيقونة دائرية صغيرة
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(icon, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 20),
            // نصوص الزر
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.orange.shade300, size: 18),
          ],
        ),
      ),
    );
  }
}