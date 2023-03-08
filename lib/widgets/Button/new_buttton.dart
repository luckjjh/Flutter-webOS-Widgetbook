import 'package:flutter/material.dart';
import '../FocusableWidget/focusable.dart';
import '../Marquee/flutter_marquee.dart';
import '../Icon/icon.dart';
import 'dart:core';

class NewButton extends StatefulWidget {
  const NewButton(
      {super.key,
      this.backgroundOpacity = 'opaque',
      this.selected = false,
      this.children = '',
      this.color = '',
      this.disabled = false,
      this.icon,
      this.minWidth = true,
      this.size = 'large',
      this.tooltipText = '',
      this.tooltipType = '',
      this.onClick});
  final String backgroundOpacity;
  final String color;
  final bool disabled;
  final IconData? icon;
  final bool minWidth;
  final bool selected;
  final String size;
  final String tooltipText;
  final String tooltipType;
  final String children;
  final VoidCallback? onClick;
  @override
  State<NewButton> createState() => _NewButtonState();
}

class _NewButtonState extends State<NewButton>
    with Focusable, TickerProviderStateMixin {
  String marqueeState = 'hover';
  static const double normalButtonWidth = 400;
  static const double normalIconButtonWidth = 330;
  static const EdgeInsetsGeometry iconPadding = EdgeInsets.all(0);
  static const EdgeInsetsGeometry buttonPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 3);
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1,
      upperBound: 1.05,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void handleFocus(bool value) {
    setState(() {
      super.handleFocus(value);
      value ? controller.forward() : controller.reverse();
      marqueeState = value ? 'render' : 'hover';
    });
  }

  @override
  void handleHover(bool value){
    setState(() {
      super.handleHover(value);
      value ? controller.forward() : controller.reverse();
      marqueeState = value ? 'render' : 'hover';
    });
  }

  @override
  void tapDown(TapDownDetails details) {
    if (!widget.disabled) {
      super.tapDown(details);
      controller.animateTo(1.02);
    }
  }

  @override
  void tapUp(TapUpDetails details) {
    if (!widget.disabled) {
      super.tapUp(details);
      controller.forward();
      widget.onClick?.call();
    }
  }

  @override
  void enterPress() async {
    if (!widget.disabled) {
      super.enterPress();
      await controller.reverse();
      await controller.forward();
      widget.onClick?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = Transform.scale(
      scale: controller.value,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0), color: getBaseBgColor()),
        constraints: BoxConstraints(
          maxWidth: 450,
          minWidth: widget.minWidth ? getSize()[0] : getSize()[1],
          minHeight: getSize()[1],
        ),
        child: Padding(
          padding: widget.minWidth || widget.children != ''
              ? buttonPadding
              : iconPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: widget.icon == null || widget.children == ''
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                softWrap: false,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: buildIconWidget(widget.icon),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: FlutterMarquee(
                        children: widget.children,
                        style: TextStyle(
                          fontFamily: 'text',
                          fontSize: widget.size == 'large' ? 39 : 30,
                          color: getTextColor(),
                          fontWeight: FontWeight.bold,
                        ),
                        marqueeOn: marqueeState,
                        alignment: 'left',
                        isButton: true,
                        maxWidth: _getMarqueeWidth(),
                        height: getSize()[1],
                        parentFocus: focused,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return buildFocusableWidget(childWidget);
  }

  List<double> getSize() {
    if (widget.size == 'large') {
      return [270, 72];
    } else {
      return [150, 54];
    }
  }

  double _getMarqueeWidth() {
    if (widget.icon == null) {
      return normalButtonWidth;
    } else {
      return normalIconButtonWidth;
    }
  }

  Color getBaseBgColor() {
    Color currentBgColor;
    if (widget.backgroundOpacity == 'opaque') {
      currentBgColor = focused
          ? const Color(0xfbe6e6e6)
          : widget.selected
              ? const Color(0xfb3E454D)
              : const Color(0xfb7d848c);
    } else {
      currentBgColor = focused
          ? const Color(0xfbe6e6e6)
          : widget.selected
              ? const Color(0xfb3E454D)
              : Colors.transparent;
    }
    return widget.disabled ? currentBgColor.withOpacity(0.28) : currentBgColor;
  }

  Color getTextColor() {
    Color currentTextColor;
    currentTextColor =
        focused ? const Color(0xfb4C5059) : const Color(0xfbe6e6e6);
    return widget.disabled
        ? currentTextColor.withOpacity(0.28)
        : currentTextColor;
  }

  Widget buildIconWidget(IconData? icon) {
    if (icon == null) {
      return const SizedBox.shrink();
    }
    if (widget.children == '') {
      return FlutterIcon(
        icon: icon,
        color: getTextColor(),
        size: widget.size,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: FlutterIcon(
        icon: icon,
        color: getTextColor(),
        size: widget.size,
      ),
    );
  }
}
