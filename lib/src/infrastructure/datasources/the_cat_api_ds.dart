import 'package:cats_app/src/config/constants/environment.dart';
import 'package:cats_app/src/domain/datasources/cats_data_source.dart';
import 'package:dio/dio.dart';
import '../../domain/models/cat.dart';

class TheCatApiDs extends CatsDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.theCatApiBaseUrl,
      headers: {'x-api-key': Environment.theCatApiKey}));

  @override
  Future<List<Cat>> getCats() async {
    final response = await dio.get('/breeds');
    if (response.statusCode == 200) {
      final List<Cat> cats = [];
      for (var item in response.data) {
        cats.add(Cat.fromJson(item));
      }
      return cats;
    }

    return [];
  }
}
