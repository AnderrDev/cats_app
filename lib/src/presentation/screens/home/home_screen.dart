import 'package:cats_app/src/presentation/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/models/the_cat_api_response.dart';
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
          return const _LoadingScreen();
        }
        if (controller.catData.isEmpty) {
          return const _EmptyScreen();
        }
        return Scaffold(
            appBar: const AppBarWidget(
              text: 'Cats App',
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Column(children: [
              const SizedBox(height: 10.0),
              Expanded(child: _buildGridView(controller.catData))
            ]));
      },
    );
  }

  Widget _buildGridView(List<CatData> catData) {
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
          return CardWidget(index: index, catData: catData);
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
