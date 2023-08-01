import 'package:cats_app/src/infrastructure/datasources/the_cat_api_ds.dart';
import 'package:cats_app/src/infrastructure/repositories/the_cat_api_repository_impl.dart';
import 'package:get_it/get_it.dart';

Future<void> initConfig() async {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<TheCatApiDs>(TheCatApiDs());
  getIt.registerSingleton<CatsRepositoryImpl>(
      CatsRepositoryImpl(getIt<TheCatApiDs>()));
}
