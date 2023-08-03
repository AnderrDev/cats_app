import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_router.dart';
import '../../infrastructure/models/the_cat_api_response.dart';
import '../screens/home/home_controller.dart';

class CardWidget extends GetWidget<HomeController> {
  final int index;
  final List<CatData> catData;
  const CardWidget({super.key, required this.index, required this.catData});

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20.0),
      bottomRight: Radius.circular(20.0),
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0),
    );
    return GestureDetector(
      onTap: () => Get.toNamed(AppRouter.catDetails, arguments: catData[index]),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(10, 10),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Hero(
                  tag: catData[index].catInfo.id,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: catData[index].catImage.url,
                    placeholder: (context, url) => Container(
                      color: Colors.white,
                      child: const Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.black45),
                      )),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: Colors.black.withOpacity(0.3),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.pets,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            catData[index].catInfo.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            catData[index].catInfo.countryCode,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const _ForwardBtn()
          ],
        ),
      ),
    );
  }
}

class _ForwardBtn extends StatelessWidget {
  const _ForwardBtn();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 5,
        right: 5,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(10, 10),
                blurRadius: 10.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(5.0),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 20,
          ),
        ));
  }
}
