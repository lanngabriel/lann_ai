import 'dart:ui';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../help/global.dart';
import '../model/onboard.dart';
import '../widget/background.dart';
import '../widget/custom_btn.dart';
import 'home.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();

    final list = [
      Onboard(
          title: 'Ask me Anything',
          subtitle:
              'Feeling lonely? Why don\'t you chat with me huh',
          lottie: 'ai_ask_me'),

      Onboard(
        title: 'Imagination to Reality',
        lottie: 'ai_bot',
        subtitle:
            'Imagine failing Mobile Dev, LOL',
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: c,
        itemCount: list.length,
        itemBuilder: (ctx, ind) {
          final isLast = ind == list.length - 1;

          return Stack(
            children: [

              Align(
                alignment: const Alignment(2, 3),
                child: Lottie.asset('ass/lottie/gradient1.json',
                    height: mq.height * .6, width: mq.width * .7),
              ),

              const BlurredContainer(
                alignmentX: 3,
                alignmentY: 0,
                heightFactor: 0.45,
                widthFactor: 1,
                color: Colors.deepPurple,
                isCircle: true,
              ),
              const BlurredContainer(
                alignmentX: 0,
                alignmentY: -0.75,
                heightFactor: 0.35,
                widthFactor: 0.75,
                color: Color(0xFFFFAB40),
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

              Column(

                children: [
                  Lottie.asset('ass/lottie/${list[ind].lottie}.json',
                      height: mq.height * .6, width: isLast ? mq.width * .7 : null),

                  Text(
                    list[ind].title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .75),
                  ),

                  SizedBox(height: mq.height * .020),

                  SizedBox(
                    width: mq.width * .7,
                    child: Text(
                      list[ind].subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: .5,
                          color: Theme.of(context).lightTextColor),
                    ),
                  ),

                  const Spacer(),

                  Wrap(
                    spacing: 8,
                    children: List.generate(
                        list.length,
                        (i) => Container(
                              width: i == ind ? 15 : 5,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: i == ind ? Colors.white : Colors.white54,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(6))),
                            )),
                  ),

                  const Spacer(),

                  CustomBtn(
                      onTap: () {
                        if (isLast) {
                          Get.off(() => const HomeScreen());
                        } else {
                          c.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.ease);
                        }
                      },
                      text: isLast ? 'Finish' : 'Next'),

                  const Spacer(flex: 2),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
