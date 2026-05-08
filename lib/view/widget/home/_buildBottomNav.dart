import 'package:customer/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildBottomNav(BuildContext context) {
  Get.put(CartController());

  return GetBuilder<CartController>(
    builder: (controller) => BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: 0, 
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), 
          activeIcon: Icon(Icons.home), 
          label: "home".tr
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_shipping_outlined), 
          label: "orders".tr
        ),
        BottomNavigationBarItem(
          icon: Badge(
            label: Text(
              "${controller.cartCount}",
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            isLabelVisible: controller.cartCount > 0, 
            backgroundColor: Colors.orange,
            child: const Icon(Icons.shopping_cart_outlined),
          ),
          label: "cart".tr,
        ),
        // ------------------------------------
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline), 
          label: "profile".tr
        ),
      ],
      onTap: (index) {
        if (index == 1) Navigator.pushNamed(context, "/orders");
        if (index == 2) Navigator.pushNamed(context, "/cart");
        if (index == 3) Navigator.pushNamed(context, "/profile");
      },
    ),
  );
}