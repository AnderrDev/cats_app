import 'package:animate_do/animate_do.dart';
import 'package:cats_app/src/presentation/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/cat_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (controller) {
        if (controller.isLoading.value) {
          return const _LoadingScreen(opacity: false);
        }
        if (controller.catData.isEmpty) {
          return const _EmptyScreen();
        }
        return Stack(
          children: [
            const Scaffold(
                appBar: AppBarWidget(
                  text: 'Cats App',
                  centerTitle: true,
                  backgroundColor: Colors.white,
                ),
                body: Column(children: [
                  SizedBox(height: 10.0),
                  Expanded(child: _CatsGridList())
                ])),
            Obx(() => controller.isLoading.value
                ? const _LoadingScreen(opacity: true)
                : const SizedBox())
          ],
        );
      },
    );
  }
}

class _CatsGridList extends StatefulWidget {
  const _CatsGridList();

  @override
  State<_CatsGridList> createState() => _CatsGridListState();
}

class _CatsGridListState extends State<_CatsGridList> {
  final scrollController = ScrollController();
  final controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadMoreCats();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        itemCount: controller.catData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
        ),
        itemBuilder: (context, index) {
          return CardWidget(index: index, catData: controller.catData);
        });
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

class _LoadingScreen extends StatelessWidget {
  final bool opacity;
  const _LoadingScreen({required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: opacity ? Colors.white.withOpacity(0.8) : Colors.white,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _CatLoader(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Loading cats...',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class _CatLoader extends StatelessWidget {
  const _CatLoader();

  @override
  Widget build(BuildContext context) {
    return SpinPerfect(
      infinite: true,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF030A1A),
        ),
        child: Image.asset(
          'assets/splash/splash_ico.png',
          fit: BoxFit.contain,
          color: const Color.fromARGB(255, 255, 255, 255),
          width: 70.0,
          height: 70.0,
        ),
      ),
    );
  }
}
