import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import '../../../core/class/status_request.dart';
import '../widget/home/_buildHeroSection.dart'; 
import '../widget/home/_buildSectionTitle.dart'; 
import '../widget/home/_buildHorizontalList.dart'; 
import '../widget/home/_buildProductsGrid.dart'; 
import '../widget/home/_buildBottomNav.dart'; 
import '../widget/home/_buildInvestmentGrid.dart'; 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تهيئة المتحكم
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "ELITE SILVER 925",
          style: TextStyle(letterSpacing: 5, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/search"),
            icon: const Icon(Icons.search, color: Colors.white),
          )
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          // معالجة حالات الطلب (تحميل، خطأ، نجاح)
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (controller.statusRequest == StatusRequest.offlinefailure) {
            return  Center(child: Text("no_internet_connection".tr, style: TextStyle(color: Colors.white)));
          } else if (controller.statusRequest == StatusRequest.serverfailure) {
            return  Center(child: Text("server_error".tr, style: TextStyle(color: Colors.white)));
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Hero Section (Banner)
                  HeroSliderSection(),

                  // 2. قسم استثمار الفضة
                  buildSectionTitle("silver_investment".tr),
                  buildInvestmentGrid(controller.investmentProducts),

                  // 3. قسم الفئات
                  buildSectionTitle("categories".tr),
                  buildHorizontalList(controller.categories, isCircle: true),

                  // 4. قسم المنتجات (Grid)
                  buildSectionTitle("products".tr),
                  buildProductsGrid(controller.products),
                  
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: buildBottomNav(context),
    );
  } 
}