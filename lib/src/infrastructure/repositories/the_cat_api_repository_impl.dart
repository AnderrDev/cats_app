import 'package:cats_app/src/domain/models/cat_image.dart';
import 'package:cats_app/src/domain/repositories/cats_repository.dart';
import 'package:cats_app/src/infrastructure/datasources/cat_api_ds.dart';
import '../../domain/models/cat.dart';

class CatsRepositoryImpl extends CatsRepositoryInterface {
  final TheCatApiDs catsDataSource;

  CatsRepositoryImpl(this.catsDataSource);

  @override
  Future<List<Cat>> getCats() async {
    return await catsDataSource.getCats();
  }

  @override
  Future<dynamic> getCatById(String breedId) async {
    return await catsDataSource.getCatById(breedId);
  }

  @override
  Future<CatImage> getCatImage(String catId) async {
    return await catsDataSource.getCatImage(catId);
  }
}
