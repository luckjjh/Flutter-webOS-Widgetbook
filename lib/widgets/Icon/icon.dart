import 'package:flutter/material.dart';

class FlutterIcon extends StatelessWidget {
  const FlutterIcon(
      {super.key,
      required this.icon,
      this.filp,
      this.size = 'small',
      this.sizeNum = 24});
  final IconData icon;
  final String? filp;
  final String size;
  final double sizeNum;
  @override
  Widget build(BuildContext context) {
    late double curSize;
    if (size == 'small') {
      curSize = 30;
    } else if (size == 'medium') {
      curSize = 40;
    } else if (size == 'large') {
      curSize = 50;
    } else if (size == 'tiny') {
      curSize = 20;
    } else {
      curSize = sizeNum;
    }
    return Icon(
      icon,
      size: curSize,
    );
  }
}
