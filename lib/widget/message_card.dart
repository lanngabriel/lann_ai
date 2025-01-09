import 'package:flutter/cupertino.dart';

import '../main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../help/global.dart';
import '../model/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const r = Radius.circular(20);

    return message.msgType == MessageType.bot

        ? Row(children: [
            const SizedBox(width: 6),

            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              child: Image.asset('ass/images/logo.png', width: 36),
            ),

            Container(
              constraints: BoxConstraints(maxWidth: mq.width * .6),
              margin: EdgeInsets.only(
                  bottom: mq.height * .02, left: mq.width * .02),
              padding: EdgeInsets.symmetric(
                  vertical: mq.height * .015, horizontal: mq.width * .03),
              decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor.withOpacity(.075),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: const BorderRadius.only(
                      topLeft: r, topRight: r, bottomRight: r)),
              child: message.msg.isEmpty
                  ? AnimatedTextKit(animatedTexts: [
                      TypewriterAnimatedText(
                        ' Please wait... ',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ], repeatForever: true)
                  : Text(
                      style: TextStyle(color: Theme.of(context).lightTextColor),
                      message.msg,
                      textAlign: TextAlign.center,
                    ),
            )
          ])

        : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            //
            Container(
                constraints: BoxConstraints(maxWidth: mq.width * .6),
                margin: EdgeInsets.only(
                    bottom: mq.height * .025, right: mq.width * .02),
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * .015, horizontal: mq.width * .025),
                decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor.withOpacity(.075),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.only(
                        topLeft: r, topRight: r, bottomLeft: r)),
                child: Text(
                  message.msg,
                  style: TextStyle(color: Theme.of(context).lightTextColor),
                  textAlign: TextAlign.center,
                )),

             CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              child: Icon(CupertinoIcons.person_crop_circle,
                color: Theme.of(context).lightTextColor,
                size: 36,),
            ),

            const SizedBox(width: 6),
          ]);
  }
}
