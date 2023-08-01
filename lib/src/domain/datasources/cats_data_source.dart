import '../models/cat.dart';

abstract class CatsDataSource {
  Future<List<Cat>> getCats();
}
