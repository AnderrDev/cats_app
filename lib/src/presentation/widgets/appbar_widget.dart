import 'package:cats_app/src/presentation/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../delegates/search_cat_delegate.dart';

class AppBarWidget extends GetWidget<HomeController>
    implements PreferredSizeWidget {
  final String text;
  final bool centerTitle;
  final Widget? action;
  final double height;
  final TextStyle? textStyle;
  final Color backgroundColor;

  const AppBarWidget(
      {super.key,
      required this.text,
      this.centerTitle = true,
      this.action,
      this.height = 60.0,
      this.textStyle,
      this.backgroundColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        toolbarHeight: height,
        title: Text(
          text,
          style: textStyle ??
              const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
        ),
        actions: [
          //Show search delegate screen for search cats
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate:
                        SearchCatDelegate(searchCat: controller.searchCatById));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              )),
        ],
        centerTitle: centerTitle,
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF030A1A),
          ),
          margin: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            'assets/splash/splash_ico.png',
            fit: BoxFit.contain,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: backgroundColor, // Asignar un color de fondo al AppBar
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
