import 'package:cats_app/src/domain/models/cat_image.dart';

import '../models/cat.dart';

abstract class CatsRepositoryInterface {
  Future<List<Cat>> getCats(int page);
  Future<Cat?> getCatById(String breedId);
  Future<CatImage> getCatImage(String catId);
}
