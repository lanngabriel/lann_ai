import 'dart:developer';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../apt/apt.dart';
import '../help/global.dart';
import '../help/dialog.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();
  final status = Status.none.obs;
  final url = ''.obs;
  final imageList = <String>[].obs;

  Future<void> createAIImage() async {
    if (textC.text.trim().isNotEmpty) {
      OpenAI.apiKey = apiKey;
      status.value = Status.loading;

      OpenAIImageModel image = await OpenAI.instance.image.create(
        prompt: textC.text,
        n: 1,
        size: OpenAIImageSize.size512,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      url.value = image.data[0].url.toString();

      status.value = Status.complete;
    } else {
      MyDialog.info('Provide some beautiful image description!');
    }
  }

  void downloadImage() async {
    try {
      MyDialog.showLoadingDialog();
      log('url: $url');

      final bytes = (await get(Uri.parse(url.value))).bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      log('filePath: ${file.path}');
      await GallerySaver.saveImage(file.path, albumName: appName)
          .then((success) {
        Get.back();

        MyDialog.success('Image Downloaded to Gallery!');
      });
    } catch (e) {
      Get.back();
      MyDialog.error('Something Went Wrong (Try again in sometime)!');
      log('downloadImageE: $e');
    }
  }

  void shareImage() async {
    try {
      MyDialog.showLoadingDialog();
      log('url: $url');

      final bytes = (await get(Uri.parse(url.value))).bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      log('filePath: ${file.path}');
      Get.back();

      await Share.shareXFiles([XFile(file.path)],
          text:
              'LANN');
    } catch (e) {
      Get.back();
      MyDialog.error('Something Went Wrong (Try again in sometime)!');
      log('downloadImageE: $e');
    }
  }

  Future<void> searchAiImage() async {
    if (textC.text.trim().isNotEmpty) {
      status.value = Status.loading;

      imageList.value = await APIs.searchAiImages(textC.text);

      if (imageList.isEmpty) {
        MyDialog.error('Something went wrong (Try again in sometime)');
        return;
      }
      url.value = imageList.first;
      status.value = Status.complete;
    } else {
      MyDialog.info('Please describe an image');
    }
  }
}