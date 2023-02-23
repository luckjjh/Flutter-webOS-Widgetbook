import 'package:flutter/material.dart';
import '../FocusableWidget/focusable_widget.dart';
import '../Marquee/flutter_marquee.dart';
import '../Icon/icon.dart';
import 'dart:core';

class Button extends StatefulWidget {
  const Button(
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
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  bool _fcshvred = false;
  String _marqueeState = 'hover';
  static const double normalButtonWidth = 400;
  static const double normalIconButtonWidth = 330;
  static const EdgeInsetsGeometry iconPadding = EdgeInsets.all(0);
  static const EdgeInsetsGeometry buttonPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 3);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltipText,
      padding: const EdgeInsets.only(top: 16),
      decoration: getTooltipShape(),
      showDuration: const Duration(seconds: 0),
      waitDuration: const Duration(milliseconds: 700),
      textStyle: const TextStyle(fontSize: 24, color: Color(0xfbe6e6e6)),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 450,
          minWidth: widget.minWidth ? getSize()[0] : getSize()[1],
          minHeight: getSize()[1],
        ),
        child: FocusableWidget(
          onFocus: _onFocus,
          selected: widget.selected,
          disabled: widget.disabled,
          onClick: widget.onClick,
          backgroundOpacity: widget.backgroundOpacity,
          child: Padding(
            padding: widget.minWidth ? buttonPadding : iconPadding,
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
                          marqueeOn: _marqueeState,
                          alignment: 'left',
                          isButton: true,
                          maxWidth: _getMarqueeWidth(),
                          height: getSize()[1],
                          parentFocus: _fcshvred,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Decoration getTooltipShape() {
    if (widget.tooltipType == 'ballon') {
      return const ShapeDecoration(
          color: Color(0xfbe6e6e6), shape: ToolTipCustomShape());
    } else {
      return const BoxDecoration(color: Colors.transparent);
    }
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

  Color getTextColor() {
    Color currentTextColor;
    currentTextColor =
        _fcshvred ? const Color(0xfb4C5059) : const Color(0xfbe6e6e6);
    return widget.disabled
        ? currentTextColor.withOpacity(0.28)
        : currentTextColor;
  }

  void _onFocus(bool value) {
    setState(() {
      _fcshvred = value;
      _marqueeState = value ? 'render' : 'hover';
    });
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

class ToolTipCustomShape extends ShapeBorder {
  final bool usePadding;

  const ToolTipCustomShape({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 20));
    return Path()
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 3)))
      ..moveTo(rect.bottomCenter.dx - 10, rect.bottomCenter.dy)
      ..relativeLineTo(10, 20)
      ..relativeLineTo(10, -20)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
