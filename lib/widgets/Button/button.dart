import 'dart:async';

import 'package:flutter/material.dart';
import '../FocusableWidget/focusable_widget.dart';
import '../Marquee/flutter_marquee.dart';
import '../Icon/icon.dart';

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
  Color _textColor = Colors.white;
  bool _fcshvred = false;
  String _marqueeState = 'hover';
  static const double normalButtonWidth = 390;
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
    return Container(
      constraints: BoxConstraints(
        maxWidth: 450,
        minWidth: widget.minWidth ? 270 : 72,
        minHeight: 72,
      ),
      child: FocusableWidget(
        onFocus: _onFocus,
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
                          fontSize: 35,
                          color: _textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        marqueeOn: _marqueeState,
                        alignment: 'left',
                        isButton: true,
                        maxWidth: _getMarqueeWidth(),
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
    );
  }

  double _getMarqueeWidth() {
    if (widget.icon == null) {
      return normalButtonWidth;
    } else {
      return normalIconButtonWidth;
    }
  }

  void _onFocus(bool value) {
    setState(() {
      _fcshvred = value;
      _textColor = value ? const Color(0xfb4C5059) : const Color(0xfbe6e6e6);
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
        color: _textColor,
        size: 'large',
      );
    }
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: FlutterIcon(
        icon: icon,
        color: _textColor,
        size: 'large',
      ),
    );
  }
}
