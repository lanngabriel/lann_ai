import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredContainer extends StatelessWidget {
  final double alignmentX;
  final double alignmentY;
  final double heightFactor;
  final double widthFactor;
  final Color color;
  final bool isCircle;
  final double? blurX;
  final double? blurY;

  const BlurredContainer({
    Key? key,
    required this.alignmentX,
    required this.alignmentY,
    required this.heightFactor,
    required this.widthFactor,
    required this.color,
    this.isCircle = false,
    this.blurX,
    this.blurY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    Widget container = Align(
      alignment: Alignment(alignmentX, alignmentY),
      child: Container(
        height: mq.height * heightFactor,
        width: mq.width * widthFactor,
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          color: color,
        ),
      ),
    );

    if (blurX != null && blurY != null) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurX!, sigmaY: blurY!),
        child: container,
      );
    }

    return container;
  }
}
