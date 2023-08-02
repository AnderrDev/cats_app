import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final void Function()? onPressedBack;
  final bool showBackButton;
  final bool centerTitle;
  final void Function()? onPressedNotification;
  final Widget? action;
  final double height;
  final TextStyle? textStyle;
  final Color backgroundColor;

  const AppBarWidget(
      {super.key,
      required this.text,
      this.showBackButton = false,
      this.centerTitle = true,
      this.action,
      this.onPressedBack,
      this.onPressedNotification,
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
          action ?? const SizedBox(),
        ],
        centerTitle: centerTitle,
        leading: !showBackButton
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.black),
                onPressed: onPressedBack ?? () => Navigator.pop(context),
                color: Colors.white,
                iconSize: 20,
                splashColor: const Color.fromARGB(79, 224, 224, 224),
                highlightColor: const Color.fromARGB(53, 189, 189, 189),
              ),
        backgroundColor: backgroundColor, // Asignar un color de fondo al AppBar
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
