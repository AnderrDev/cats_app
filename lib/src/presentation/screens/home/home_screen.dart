import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats_app/src/presentation/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(children: [
                  Expanded(
                    child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        itemCount: controller.catData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                        ),
                        itemBuilder: (context, index) {
                          return _buildCard(controller, index, context);
                        }),
                  )
                ])));
      },
    );
  }

  Container _buildCard(
      HomeController controller, int index, BuildContext context) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20.0),
      bottomRight: Radius.circular(20.0),
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0),
    );
    return Container(
      clipBehavior:  Clip.antiAlias,
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
                tag: controller.catData[index].catInfo.id,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: controller.catData[index].catImage.url.isNotEmpty
                      ? controller.catData[index].catImage.url
                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
                  placeholder: (context, url) => Container(
                    color: Colors.white,
                    child: const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
                    )),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                          controller.catData[index].catInfo.name,
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
                          controller.catData[index].catInfo.countryCode,
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
          Positioned(
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
              ))
        ],
      ),
    );
  }
}
