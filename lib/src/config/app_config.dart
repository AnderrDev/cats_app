import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats_app/src/domain/repositories/cats_repository.dart';
import 'package:cats_app/src/infrastructure/datasources/cat_api_ds.dart';
import 'package:cats_app/src/infrastructure/repositories/the_cat_api_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

Future<void> initConfig() async {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<TheCatApiDs>(TheCatApiDs());
  getIt.registerSingleton<CatsRepositoryImpl>(
      CatsRepositoryImpl(getIt<TheCatApiDs>()));
  getIt.registerSingleton<CatsRepositoryInterface>(getIt<CatsRepositoryImpl>());
}
