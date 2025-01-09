import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/chat_controller.dart';
import '../../help/global.dart';
import '../../widget/background.dart';
import '../../widget/message_card.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  final _c = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LANN'),
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
                hintText: 'Message LANN',
                hintStyle: const TextStyle(fontSize: 14),
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

          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).buttonColor,
            child: IconButton(
              onPressed: _c.askQuestion,
              icon: Icon(Icons.send,
                  color: Theme.of(context).buttonColor.withOpacity(.7), size: 28),
            ),
          )
        ]),
      ),

      body: Stack(
        children: [
          const BlurredContainer(
            alignmentX: 3,
            alignmentY: 0,
            heightFactor: 0.45,
            widthFactor: 1,
            color: Colors.deepPurple,
            isCircle: true,
          ),
          Align(
            alignment: const Alignment(0, 2.5),
            child: Lottie.asset('ass/lottie/gradient1.json',
                height: mq.height * .6, width: mq.width * .7),
          ),
          Align(
            alignment: const Alignment(-2, -1),
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
          Obx(
            () => ListView(
              physics: const BouncingScrollPhysics(),
              controller: _c.scrollC,
              padding:
                  EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .1),
              children: _c.list.map((e) => MessageCard(message: e)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
