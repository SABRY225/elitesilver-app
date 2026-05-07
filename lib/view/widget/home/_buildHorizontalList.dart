import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildHorizontalList(List list, {bool isCircle = false}) {
  if (list.isEmpty) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "No data available at this time.".tr,
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  return SizedBox(
    // زيادة الارتفاع قليلاً لاستيعاب الظلال والنصوص بشكل مريح
    height: isCircle ? 140 : 170,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const BouncingScrollPhysics(), // إضافة تأثير ارتداد احترافي
      itemCount: list.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            if (list[i]['id'] == 6) {
              Navigator.pushNamed(
              context,
              "/custom-order",
            );
            }else{
            Navigator.pushNamed(
              context,
              "/category",
              arguments: {"category": list[i]},
            );

            }

          },
          child: Container(
            width: isCircle ? 90 : 120,
            margin: const EdgeInsets.only(right: 12, top: 5, bottom: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // تصميم حاوية الصورة
                Container(
                  decoration: BoxDecoration(
                    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius: isCircle ? null : BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: isCircle
                        ? BorderRadius.circular(50)
                        : BorderRadius.circular(15),
                    child: Image.network(
                      'http://192.168.1.5:5000/${list[i]['image_url']}',
                      fit: BoxFit.cover,
                      width: isCircle ? 85 : 120,
                      height: isCircle ? 85 : 110,
                      // إضافة Loading placeholder أثناء تحميل الصورة
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: isCircle ? 85 : 120,
                          height: isCircle ? 85 : 110,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                      // التعامل مع الأخطاء
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: isCircle ? 85 : 120,
                        height: isCircle ? 85 : 110,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // النص مع تحسين العرض
                Text(
                  list[i]['name'],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: isCircle ? FontWeight.normal : FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
