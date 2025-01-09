import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled_ai/main.dart';

import '../../controller/image_controller.dart';
import '../../help/global.dart';
import '../../widget/background.dart';
import '../../widget/custom_loading.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final _c = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Playground'),

        actions: [
          Obx(
            () => _c.status.value == Status.complete
                ? Row(
                  children: [
                    IconButton(
                        onPressed: _c.downloadImage,
                        icon: const Icon(Icons.file_download_outlined)),
                    const SizedBox(width: 1),
                    IconButton(
                        padding: const EdgeInsets.only(right: 5),
                        onPressed: _c.shareImage,
                        icon: const Icon(Icons.share_rounded)),
                  ],
                )
                : const SizedBox(),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Expanded(
              child: TextFormField(
                controller: _c.textC,
                textAlign: TextAlign.start,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                cursorColor: Theme.of(context).lightTextColor,
                decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    isDense: true,
                    hintText: 'Describe an image',
                    hintStyle: const TextStyle(fontSize: 14, letterSpacing: .75),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),

                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).lightTextColor.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(50)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).lightTextColor.withOpacity(.7)),
                        borderRadius: BorderRadius.circular(50)
                    ),

                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              )),

          const SizedBox(width: 8),

          ElevatedButton(onPressed:  _c.searchAiImage,
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 0,
                  backgroundColor: Theme.of(context).buttonColor,
                  textStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1),
                  minimumSize: Size(mq.width * .25, 50),
              ),
              child: const Text('Create')),
        ]),
      ),

      body: Stack(
        children: [
          Align(
            alignment: const Alignment(2, 3),
            child: Lottie.asset('ass/lottie/gradient1.json',
                height: mq.height * .6, width: mq.width * .7),
          ),
          Align(
            alignment: const Alignment(-3, -3),
            child: Lottie.asset('ass/lottie/gradient1.json',
                height: mq.height * .6, width: mq.width * .7),
          ),
          const BlurredContainer(
            alignmentX: 0,
            alignmentY: 0,
            heightFactor: 0,
            widthFactor: 0,
            color: Colors.transparent,
            blurX: 100,
            blurY: 100,
          ),
          const BlurredContainer(
            alignmentX: 0,
            alignmentY: 0,
            heightFactor: 0,
            widthFactor: 0,
            color: Colors.transparent,
            blurX: 50,
            blurY: 50,
          ),
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
                top: mq.height * .02,
                bottom: mq.height * .1,
                left: mq.width * .04,
                right: mq.width * .04),
            children: [
              Container(
                  height: mq.height * .5,
                  margin: EdgeInsets.symmetric(vertical: mq.height * .015),
                  alignment: Alignment.center,
                  child: Obx(() => _aiImage())),

              Obx(() => _c.imageList.isEmpty
                  ? const SizedBox()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(bottom: mq.height * .03),
                      physics: const BouncingScrollPhysics(),
                      child: Wrap(
                        spacing: 10,
                        children: _c.imageList
                            .map((e) => InkWell(
                                  onTap: () {
                                    _c.url.value = e;
                                  },
                                  child: ClipRRect(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(8)),
                                    child: CachedNetworkImage(
                                      imageUrl: e,
                                      height: 100,
                                      errorWidget: (context, url, error) =>
                                          const SizedBox(),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aiImage() => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: switch (_c.status.value) {
          Status.none =>
            Stack(
              children: [
                Lottie.asset('ass/lottie/ai_chatting.json', height: mq.height * .5),
                Center(child: ShaderMask(
                  shaderCallback: (bounds) =>
                      const LinearGradient(
                        colors: [Colors.blue, Colors.greenAccent, Colors.redAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: const Text(
                    'Describe an image',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white, // This color is overridden by the shader
                    ),
                  ),
                ),
                ),
                const BlurredContainer(
                  alignmentX: 0,
                  alignmentY: 0,
                  heightFactor: 0,
                  widthFactor: 0,
                  color: Colors.transparent,
                  blurX: 15,
                  blurY: 15,
                ),
                Center(child: ShaderMask(
                  shaderCallback: (bounds) =>
                      const LinearGradient(
                        colors: [Colors.blue, Colors.greenAccent, Colors.redAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: const Text(
                    'Describe an image',
                    style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white, // This color is overridden by the shader
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Status.complete => CachedNetworkImage(
              imageUrl: _c.url.value,
              placeholder: (context, url) => const CustomLoading(),
              errorWidget: (context, url, error) => const SizedBox(), //imma change
            ),
          Status.loading => const CustomLoading()
        },
      );
}
