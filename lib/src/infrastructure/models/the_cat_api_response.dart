import 'package:cats_app/src/domain/models/cat_image.dart';

import '../../domain/models/cat.dart';

class CatData {
  final Cat catInfo;
  final CatImage catImage;

  CatData({required this.catInfo, required this.catImage});

  factory CatData.fromJson(Map<String, dynamic> json) {
    return CatData(
        catInfo: Cat.fromJson(json['cat']),
        catImage: CatImage.fromJson(json['catImage']));
  }
}
