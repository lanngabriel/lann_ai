import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled_ai/main.dart';

import '../../controller/image_controller.dart';
import '../../controller/translate_controller.dart';
import '../../help/global.dart';
import '../../widget/background.dart';
import '../../widget/custom_btn.dart';
import '../../widget/custom_loading.dart';
import '../../widget/language_sheet.dart';

class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

class _TranslatorFeatureState extends State<TranslatorFeature> {
  final _c = TranslateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate'),
      ),
      body: Stack(
        children: [
          const BlurredContainer(
            alignmentX: 0,
            alignmentY: 0,
            heightFactor: 0.35,
            widthFactor: 0.75,
            color: Color(0xFFFFAB40),
          ),
          Align(
            alignment: const Alignment(0, 2.5),
            child: Lottie.asset('ass/lottie/gradient1.json',
                height: mq.height * .6, width: mq.width * .7),
          ),
          Align(
            alignment: const Alignment(-2.75, -1.5),
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
            padding: EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .1),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mq.width * .04, vertical: mq.height * .035),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  // FROM
                  InkWell(
                    onTap: () => Get.bottomSheet(LanguageSheet(c: _c, s: _c.from)),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      height: 50,
                      width: mq.width * .4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor.withOpacity(.075),
                          border: Border.all(color: Colors.blue),
                          borderRadius: const BorderRadius.all(Radius.circular(50))),
                      child:
                          Obx(() => Text(_c.from.isEmpty ? 'Auto' : _c.from.value, style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                      SizedBox(height: mq.height * .01),

                      TextFormField(
                        controller: _c.textC,
                        minLines: 2,
                        maxLines: null,
                        onTapOutside: (e) => FocusScope.of(context).unfocus(),
                        decoration: const InputDecoration(
                            hintText: 'Enter Text',
                            hintStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)))),
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                      ),

                  Row(
                    children: [
                      Expanded(child: Divider(
                        color: Theme.of(context).lightTextColor.withOpacity(.4),
                        thickness: 2,)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                        child: Center(
                          child: IconButton(
                              onPressed: _c.swapLanguages,
                              icon: Obx(
                                () => Icon(
                                  CupertinoIcons.repeat,
                                  color: _c.to.isNotEmpty && _c.from.isNotEmpty
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              )),
                        ),
                      ),
                      Expanded(child: Divider(
                        color: Theme.of(context).lightTextColor.withOpacity(.4),
                        thickness: 2,)),
                    ],
                  ),
                  // TO
                  InkWell(
                    onTap: () => Get.bottomSheet(LanguageSheet(c: _c, s: _c.to)),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      height: 50,
                      width: mq.width * .4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor.withOpacity(.075),
                          border: Border.all(color: Colors.blue),
                          borderRadius: const BorderRadius.all(Radius.circular(50))),
                      child: Obx(() => Text(_c.to.isEmpty ? 'To' : _c.to.value,style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                    ),
                  ),
                      SizedBox(height: mq.height * .01),
                      Obx(() => _translateResult()),
                ]),
              ),

              SizedBox(height: mq.height * .01),

              CustomBtn(
                onTap: _c.googleTranslate,
                // onTap: _c.translate,
                text: 'Translate',
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _translateResult() => switch (_c.status.value) {
        //Status.none => const SizedBox(),
        Status.none => TextFormField(
          controller: _c.resultC,
          minLines: 2,
          maxLines: null,
          readOnly: true,
          onTapOutside: (e) => FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(
              hintText: 'Translation',
              hintStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        Status.complete => TextFormField(
          controller: _c.resultC,
          minLines: 2,
          maxLines: null,
          readOnly: true,
          onTapOutside: (e) => FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(
              hintText: 'Translation',
              hintStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        Status.loading => const Align(child: CustomLoading())
      };
}
