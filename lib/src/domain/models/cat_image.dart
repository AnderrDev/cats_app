import 'dart:convert';

List<CatImage> catImageFromJson(String str) =>
    List<CatImage>.from(json.decode(str).map((x) => CatImage.fromJson(x)));

String catImageToJson(List<CatImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatImage {
  String id;
  String url;
  int width;
  int height;

  CatImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory CatImage.fromJson(Map<String, dynamic> json) => CatImage(
        id: json["id"],
        url: json["url"],
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
