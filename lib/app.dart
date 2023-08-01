import 'package:cats_app/src/config/app_router.dart';
import 'package:cats_app/src/config/app_theme.dart';
import 'package:cats_app/src/presentation/bloc/cats/cats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CatsBloc>(
        create: (BuildContext context) => CatsBloc(),
      ),
    ], child: const _App());
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRouter.getRoutes(),
      onGenerateRoute: AppRouter.generateRoutes,
    );
  }
}
