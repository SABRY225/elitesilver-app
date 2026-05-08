import 'package:customer/data/datasource/remote/linkapi.dart';
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
    height: isCircle ? 140 : 170,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const BouncingScrollPhysics(), 
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
                      '${AppLink.imagesStatic}/${list[i]['image_url']}',
                      fit: BoxFit.cover,
                      width: isCircle ? 85 : 120,
                      height: isCircle ? 85 : 110,
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
