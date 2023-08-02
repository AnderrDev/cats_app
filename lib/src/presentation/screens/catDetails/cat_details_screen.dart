import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cat_details_screen_controller.dart';

class CatDetailsScreen extends StatelessWidget {
  const CatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatDetailsController>(
      init: CatDetailsController(),
      initState: (_) {},
      builder: (_) {
        return const Scaffold(
          body: Column(
            children: [
              _CatImg(),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _CatDetails()),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CatDetails extends GetWidget<CatDetailsController> {
  const _CatDetails();

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<CatDetailsController>();
    final catData = _.catData;
    final catInfo = catData.catInfo;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildTextRow('Name', catInfo.name, fontWeight: FontWeight.bold),
        _buildTextRow('Description', catInfo.description),
        _buildTextRow('Origin', catInfo.origin),
        _buildTextRow('Life Span', catInfo.lifeSpan),
        _buildTextRow('Temperament', catInfo.temperament),
        _buildTextRow('Weight', '${catInfo.weight.metric} kg'),
        _buildTextRow('Adaptability', catInfo.adaptability.toString()),
        _buildTextRow('Affection Level', catInfo.affectionLevel.toString()),
        _buildTextRow('Child Friendly', catInfo.childFriendly.toString()),
        _buildTextRow('Dog Friendly', catInfo.dogFriendly.toString()),
        _buildTextRow('Energy Level', catInfo.energyLevel.toString()),
        _buildTextRow('Grooming', catInfo.grooming.toString()),
        _buildTextRow('Health Issues', catInfo.healthIssues.toString()),
        _buildTextRow('Intelligence', catInfo.intelligence.toString()),
        _buildTextRow('Shedding Level', catInfo.sheddingLevel.toString()),
        _buildTextRow('Social Needs', catInfo.socialNeeds.toString()),
        _buildTextRow('Stranger Friendly', catInfo.strangerFriendly.toString()),
      ],
    );
  }

  Widget _buildTextRow(String title, String value,
      {FontWeight fontWeight = FontWeight.normal}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
              fontSize: 18, fontWeight: fontWeight, color: Colors.black87),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _CatImg extends GetWidget<CatDetailsController> {
  const _CatImg();

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<CatDetailsController>();
    return Stack(
      children: [
        SizedBox(
          height: 350,
          width: double.infinity,
          child: Hero(
            tag: _.catData.catInfo.id,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: _.catData.catImage.url.isNotEmpty
                  ? _.catData.catImage.url
                  : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
              placeholder: (context, url) => Container(
                color: Colors.white,
                child: const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
                )),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const _BackBtn()
      ],
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 40,
        left: 20,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(10, 10),
                  blurRadius: 10.0,
                ),
              ],
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 25,
            ),
          ),
        ));
  }
}
