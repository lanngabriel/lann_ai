import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled_ai/model/home_type.dart';
import 'package:untitled_ai/widget/home_card.dart';

import '../apt/apt.dart';
import '../help/global.dart';
import '../help/pref.dart';
import '../widget/background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _isDarkMode = Get.isDarkMode.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Pref.showOnboarding = false;
  }

  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.sizeOf(context);

    //APIs.getAnswer('question');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(appName),
      actions: [IconButton(
        padding: const EdgeInsets.only(right: 10),
          onPressed: (){
            Get.changeThemeMode(
                _isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
            _isDarkMode.value = !_isDarkMode.value;
            Pref.isDarkMode = _isDarkMode.value;
          },
          icon: Obx(() => Icon(
              _isDarkMode.value
                  ? Icons.brightness_5_rounded
                  : Icons.brightness_5_rounded,
              size: 26)))
        ],
      ),

      body: Stack(
        children: [
          Align(
            alignment: const Alignment(2, 3),
            child: Lottie.asset('ass/lottie/gradient1.json',
                height: mq.height * .6, width: mq.width * .7),
          ),
          Align(
            alignment: const Alignment(-3, -1.5),
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
            padding: EdgeInsets.symmetric(
              horizontal: mq.width * 0.04,
              vertical: mq.height * .015,
            ),
            children: HomeType.values.map((e) => HomeCard(homeType: e,)).toList(),
          ),
        ],
      ),
    );
  }
}
