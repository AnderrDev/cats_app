import 'package:cats_app/src/domain/models/cat.dart';
import 'package:cats_app/src/domain/models/cat_image.dart';
import 'package:cats_app/src/domain/repositories/cats_repository.dart';
import 'package:cats_app/src/infrastructure/models/the_cat_api_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class HomeController extends GetxController {
  late CatsRepositoryInterface _catsRepository;
  final RxList<Cat> _cats = <Cat>[].obs;
  final RxList<CatData> _catData = <CatData>[].obs;
  final RxList<CatData> _catDataFiltered = <CatData>[].obs;
  final RxBool _isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  List<CatData> get catDataFiltered => _catDataFiltered;
  List<Cat> get cats => _cats;
  List<CatData> get catData => _catData;
  RxBool get isLoading => _isLoading;
  set setloading(bool value) => _isLoading.value = value;


  @override
  void onInit() {
    super.onInit();
    _catsRepository = GetIt.I<CatsRepositoryInterface>();
    _loadCats(0);
  }

  _loadCats(int page) async {
    setloading = true;
    try {
      // Get the cats from the repository
      final response = await _catsRepository.getCats(page);
      _cats.value = response;

      // Get the images for each cat
      for (var cat in _cats) {
        CatData data =
            CatData(catImage: await _loadImages(cat.id), catInfo: cat);
        _catData.add(data);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    setloading = false;
    update();
  }

  Future<CatImage> _loadImages(String catId) async {
    final response = await _catsRepository.getCatImage(catId);
    return response;
  }

  Future<List<CatData>> searchCatById(String query) async {
    _catDataFiltered.clear();
    final response = await _catsRepository.getCatById(query);
    if (response != null) {
      CatData data =
          CatData(catImage: await _loadImages(response.id), catInfo: response);
      _catDataFiltered.clear();
      _catDataFiltered.add(data);
      return _catDataFiltered;
    }
    return _catDataFiltered;
  }
}
