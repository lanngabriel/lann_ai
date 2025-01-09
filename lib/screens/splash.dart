import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_ai/screens/onboarding.dart';

import '../help/global.dart';
import '../help/pref.dart';
import '../widget/custom_loading.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      Get.off(() =>
      Pref.showOnboarding
          ? const OnboardingScreen()
          : const HomeScreen());
          //: const OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      //body
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            const Spacer(flex: 2),
            Card(
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.all(mq.width * .05),
                child: Image.asset(
                  'ass/images/logo.png',
                  width: mq.width * .4,
                ),
              ),
            ),

            const Spacer(),
            const CustomLoading(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
