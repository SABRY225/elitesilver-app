import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/order/order_controller.dart';
import '../../../core/class/status_request.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "my_orders".tr,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: GetBuilder<OrderController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          } else if (controller.statusRequest == StatusRequest.offlinefailure) {
            return _buildErrorState(
              "no_internet_connection".tr,
              Icons.wifi_off_rounded,
            );
          } else if (controller.statusRequest == StatusRequest.serverfailure) {
            return _buildErrorState("server_error".tr, Icons.dns_rounded);
          } else {
            if (controller.orders.isEmpty) {
              return _buildErrorState(
                "No orders currently available".tr,
                Icons.inventory_2_outlined,
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: controller.orders.length,
              itemBuilder: (context, index) {
                if (controller.orders[index] == null) return const SizedBox();
                return _buildOrderCard(controller.orders[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildOrderCard(Map? order) {
    if (order == null) return const SizedBox();

    String type = order['type'] ?? "عام";
    String total = order['total']?.toString() ?? "0";
    String status = order['status'] ?? "غير محدد";
    String createdAt = order['createdAt']?.toString().split('T')[0] ?? "";
    var bgColor;
    if (order['status'] == 'جديد') {
      status = "new";
      bgColor = Colors.green;
    } else if (order['status'] == 'قيد التنفيذ') {
      status = "in_processing";
      bgColor = const Color.fromARGB(255, 222, 165, 53);
    } else if (order['status'] == 'جاري الشحن') {
      status = "in_Shopping";
      bgColor = const Color.fromARGB(255, 21, 107, 192);
    } else if (order['status'] == 'مكتمل') {
      status = "completed";
      bgColor = const Color.fromARGB(255, 114, 112, 112);
    } else if (order['status'] == 'ملغي') {
      status = "cancelled";
      bgColor = const Color.fromARGB(255, 223, 32, 32);
    } else if (order['status'] == 'مرتجع') {
      status = "returned";
      bgColor = const Color.fromARGB(255, 130, 97, 56);
    }

    String city = "غير محدد";
    if (order['city'] != null && order['city'] is Map) {
      city = order['city']['name'] ?? "مدينة غير معروفة";
    }

    String itemName = "طلب فارغ";
    if (order['items'] != null && (order['items'] as List).isNotEmpty) {
      itemName = order['items'][0]['name'] ?? "منتج بدون اسم";
    }

    bool isSilver = order['type'] == "silver";

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSilver ? Colors.grey.withOpacity(0.3) : Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isSilver
                      ? Colors.blueGrey.withOpacity(0.2)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  (type.tr).toUpperCase(),
                  style: TextStyle(
                    color: isSilver ? Colors.blueGrey[200] : Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                '${total} ' + "jod".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.white10, thickness: 1),
          ),

          _buildInfoRow(
            Icons.shopping_bag_outlined,
            itemName,
            Colors.white,
            isBold: true,
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            Icons.calendar_today_outlined,
            "Order Date:".tr + "$createdAt",
            Colors.white70,
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildInfoRow(
                  Icons.location_on_outlined,
                  city,
                  Colors.white70,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String text,
    Color textColor, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isBold ? Colors.orange : Colors.white38, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white24, size: 60),
          const SizedBox(height: 15),
          Text(
            message,
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
