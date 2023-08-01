import 'package:cats_app/src/domain/models/cat_image.dart';
import 'package:cats_app/src/domain/repositories/cats_repository.dart';
import 'package:cats_app/src/infrastructure/datasources/the_cat_api_ds.dart';
import '../../domain/models/cat.dart';

class CatsRepositoryImpl extends CatsRepository {
  final TheCatApiDs catsDataSource;

  CatsRepositoryImpl(this.catsDataSource);

  @override
  Future<List<Cat>> getCats() async {
    return await catsDataSource.getCats();
  }

  @override
  Future<List<CatImage>> getCatImages(String catId) async {
    return await catsDataSource.getCatImages(catId);
  }

  
}
