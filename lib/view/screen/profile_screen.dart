import 'package:customer/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/local_storage.dart';
import '../../routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    Future.microtask(() => controller.fetchProfileData());
    final name = LocalStorage.getName() ?? "user".tr;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
            onPressed: () => controller.fetchProfileData(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white10,
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
            const SizedBox(height: 15),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem("points".tr, controller.points.value),
                    Container(width: 1, height: 40, color: Colors.white10),
                    _buildStatItem(
                      "orders_count".tr,
                      controller.orderCounter.value,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildListTile(
                      icon: Icons.inventory_2_outlined,
                      title: "my_orders".tr,
                      onTap: () => Get.toNamed(AppRoutes.orders),
                    ),
                    _buildListTile(
                      icon: Icons.favorite_border,
                      title: "favorites".tr,
                      onTap: () => Get.toNamed(AppRoutes.saved),
                    ),
                    _buildListTile(
                      icon: Icons.shopping_cart_outlined,
                      title: "cart".tr,
                      onTap: () => Get.toNamed(AppRoutes.cart),
                    ),
                    _buildListTile(
                      icon: Icons.language, 
                      title: "app_language".tr,
                      onTap: () => Get.toNamed(AppRoutes.selectLanguage),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Divider(color: Colors.white10, thickness: 1),
                    ),
                    _buildListTile(
                      icon: Icons.logout,
                      title: "logout".tr,
                      iconColor: Colors.redAccent,
                      onTap: () async {
                        await LocalStorage.clear();
                        Get.offAllNamed(AppRoutes.login);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.white70,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white24,
        size: 14,
      ),
      onTap: onTap,
    );
  }
}
