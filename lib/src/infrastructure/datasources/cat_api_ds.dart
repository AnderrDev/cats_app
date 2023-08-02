import 'dart:developer';

import 'package:cats_app/src/config/constants/environment.dart';
import 'package:cats_app/src/domain/datasources/cats_data_source.dart';
import 'package:cats_app/src/domain/models/cat_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/cat.dart';

class TheCatApiDs extends CatsDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.theCatApiBaseUrl,
    headers: {'x-api-key': Environment.theCatApiKey},
  ));

  @override
  Future<List<Cat>> getCats() async {
    try {
      final response = await dio.get('/breeds', queryParameters: {
        'limit': 15,
      });
      if (response.statusCode == 200) {
        final List<Cat> cats = [];
        for (var item in response.data) {
          cats.add(Cat.fromJson(item));
        }
        return cats;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return [];
  }

  @override
  Future<dynamic> getCatById(String breedId) async {
    try {
      final response = await dio.get('/breeds/$breedId');
      inspect(response);
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          final Cat cat = Cat.fromJson(response.data);
          return cat;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return {};
  }

  @override
  Future<CatImage> getCatImage(String catId) async {
    try {
      final response = await dio.get('/images/search', queryParameters: {
        'breed_ids': catId,
      });
      if (response.statusCode == 200) {
        if (response.data.isEmpty) {
          return CatImage();
        }
        final CatImage image = CatImage.fromJson(response.data[0]);
        return image;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return CatImage();
  }
}
