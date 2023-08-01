import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Icon(Icons.movie_creation, color: Colors.pink),
                const SizedBox(width: 10.0),
                Text('Cats App', style: titleStyle),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            )));
  }
}
