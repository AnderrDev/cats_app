import 'package:cats_app/src/presentation/bloc/cats/cats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CatsBloc, CatsState>(
          builder: (context, state) {
            context.read<CatsBloc>().add(LoadCats(cats: []));
            return Text("Hello world ${state.cats.length}");
          },
        ),
      ),
    );
  }
}
