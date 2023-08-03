import 'dart:convert';

List<CatImage> catImageFromJson(String str) =>
    List<CatImage>.from(json.decode(str).map((x) => CatImage.fromJson(x)));

String catImageToJson(List<CatImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatImage {
  final String id;
  final String url;
  final int width;
  final int height;

  CatImage({
    this.id = '',
    this.url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
    this.width = 0,
    this.height = 0,
  });

  factory CatImage.fromJson(Map<String, dynamic> json) => CatImage(
        id: json["id"],
        url: json["url"] ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
