import 'package:flutter/material.dart';

class FlutterIcon extends StatelessWidget {
  const FlutterIcon(
      {super.key,
      required this.icon,
      this.filp,
      this.size = 'small',
      this.sizeNum = 24,
      this.color = Colors.white});
  final IconData? icon;
  final String? filp;
  final String size;
  final double sizeNum;
  final Color color;
  @override
  Widget build(BuildContext context) {
    late double curSize;
    if (size == 'small') {
      curSize = 39;
    } else if (size == 'medium') {
      curSize = 45;
    } else if (size == 'large') {
      curSize = 54;
    } else if (size == 'tiny') {
      curSize = 30;
    } else {
      curSize = sizeNum;
    }
    return Icon(
      icon,
      size: curSize,
      color: color,
    );
  }
}
