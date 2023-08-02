import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats_app/src/config/app_router.dart';
import 'package:cats_app/src/presentation/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/models/the_cat_api_response.dart';
import '../../widgets/appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (controller) {
        if (controller.isLoading.value) {
          return const _LoadingScreen();
        }
        if (controller.catData.isEmpty) {
          return const _EmptyScreen();
        }
        return Scaffold(
            appBar: const AppBarWidget(
              text: 'Cats App',
              showBackButton: false,
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Column(children: [
              const _SearchBarWidget(),
              const SizedBox(height: 10.0),
              Obx(() {
                if (controller.isSearching.value) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
                if (controller.catDataFiltered.isEmpty) {
                  return Expanded(child: _buildGridView(controller.catData));
                } else {
                  return Expanded(
                      child: _buildGridView(controller.catDataFiltered));
                }
              }),
            ]));
      },
    );
  }

  GridView _buildGridView(List<CatData> catData) {
    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        itemCount: catData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
        ),
        itemBuilder: (context, index) {
          return _CardWidget(index: index, catData: catData);
        });
  }
}

class _CardWidget extends GetWidget<HomeController> {
  final int index;
  final List<CatData> catData;
  const _CardWidget({required this.index, required this.catData});

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
                    imageUrl: catData[index].catImage.url.isNotEmpty
                        ? catData[index].catImage.url
                        : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
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

class _EmptyScreen extends StatelessWidget {
  const _EmptyScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No data found',
            style: TextStyle(fontSize: 20.0, color: Colors.black)),
      ),
    );
  }
}

class _SearchBarWidget extends GetWidget<HomeController> {
  const _SearchBarWidget();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(10, 10),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              onChanged: (value) => controller.searchCats(value),
              decoration: const InputDecoration(
                hintText: 'Search by name or breed',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Loading data please wait...',
              style: TextStyle(color: Colors.black),
            )
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
