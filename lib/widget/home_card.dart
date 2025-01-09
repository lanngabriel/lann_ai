import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled_ai/main.dart';

import '../help/global.dart';
import '../model/home_type.dart';

class HomeCard extends StatelessWidget {
  final HomeType homeType;

  const HomeCard({super.key, required this.homeType});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;

    return Card(
      color: Theme.of(context).lightTextColor.withOpacity(.1),
        elevation: 0,
        margin: EdgeInsets.only(bottom: mq.height * .02),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: homeType.onTap,
          child: homeType.leftAlign
              ? Row(
                  children: [
                    //lottie
                    Container(
                      width: mq.width * .35,
                      padding: homeType.padding,
                      child: Lottie.asset('ass/lottie/${homeType.lottie}'),
                    ),

                    const Spacer(),

                    Text(
                      homeType.title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).lightTextColor,
                          letterSpacing: 1),
                    ),

                    const Spacer(flex: 2),
                  ],
                )
              : Row(
                  children: [
                    const Spacer(flex: 2),

                    Text(
                      homeType.title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).lightTextColor,
                          letterSpacing: 1),
                    ),

                    const Spacer(),

                    //lottie
                    Container(
                      width: mq.width * .35,
                      padding: homeType.padding,
                      child: Lottie.asset('ass/lottie/${homeType.lottie}'),
                    ),
                  ],
                ),
        )).animate().fade(duration: 1.seconds, curve: Curves.easeIn);
  }
}
