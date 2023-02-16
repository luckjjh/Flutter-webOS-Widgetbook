import 'package:flutter/material.dart';
import '../FocusableWidget/focusable_widget.dart';


class Button extends StatefulWidget {
  const Button({
    super.key,
    this.backgroundOpacity = 'opaque',
    this.selected = false,
    this.children = 'click me',
    this.color = '',
    this.disabled = false,
    this.icon = '',
    this.minWidth = true,
    this.size = 'large',
    this.tooltipText = '',
    this.tooltipType = '',
    this.onClick
  });
  final String backgroundOpacity;
  final String color;
  final bool disabled;
  final String icon;
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableWidget(
      onFocus: _onFocus,
      onClick: widget.onClick,
      backgroundOpacity: widget.backgroundOpacity,
      child: Tooltip(
        message: widget.tooltipText,
        child: Text(
          widget.children,
          style: TextStyle(
              fontSize: 30, color: _textColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onFocus(bool value) {
    setState(() {
      _textColor = value ? Colors.black : Colors.white;
    });
  }
}
