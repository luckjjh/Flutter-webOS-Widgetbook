import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusableWidget extends StatefulWidget {
  const FocusableWidget({
    super.key,
    this.backgroundOpacity = 'opaque',
    this.animaterable = true,
    required this.child,
    this.onFocus,
    this.onClick,
    this.disabled = false,
    this.selected = false,
  });

  final bool animaterable;
  final Widget child;
  final String backgroundOpacity;
  final Function? onFocus;
  final VoidCallback? onClick;
  final bool disabled;
  final bool selected;
  @override
  State<FocusableWidget> createState() => _FocusableWidgetWidgetState();
}

class _FocusableWidgetWidgetState extends State<FocusableWidget>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  late FocusNode _node;
  bool _focused = false;
  bool _fcshvred = false;
  late FocusAttachment _nodeAttachment;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 1,
      upperBound: 1.05,
    )..addListener(() {
        setState(() {});
      });
    _node = FocusNode();
    _node.addListener(_handleFocusChange);
    _nodeAttachment = _node.attach(context, onKey: _handleKeyPress);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.removeListener(_handleFocusChange);
    _node.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      setState(() {
        _focused = _node.hasFocus;
      });
    }
  }

  KeyEventResult _handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey.keyId == 4294967309) {
        enterPress();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    _nodeAttachment.reparent();
    _scale = _controller.value;
    if (widget.animaterable) {
      return GestureDetector(
        onTapDown: _tapDown,
        onTapUp: _tapUp,
        child: FocusableActionDetector(
          focusNode: _node,
          onShowHoverHighlight: _handleFocus,
          onShowFocusHighlight: _handleFocus,
          child: Transform.scale(
            scale: _scale,
            child: _animateButtonBox(),
          ),
        ),
      );
    }
    return GestureDetector(
      child: FocusableActionDetector(
        focusNode: _node,
        onShowHoverHighlight: _handleFocus,
        onShowFocusHighlight: _handleFocus,
        child: _animateButtonBox(),
      ),
    );
  }

  Widget _animateButtonBox() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: getBaseBgColor()),
      child: widget.child,
    );
  }

  Color getBaseBgColor() {
    Color currentBgColor;
    if (widget.backgroundOpacity == 'opaque') {
      currentBgColor = _fcshvred
          ? const Color(0xfbe6e6e6)
          : widget.selected
              ? const Color(0xfb3E454D)
              : const Color(0xfb7d848c);
    } else {
      currentBgColor = _fcshvred
          ? const Color(0xfbe6e6e6)
          : widget.selected
              ? const Color(0xfb3E454D)
              : Colors.transparent;
    }
    return widget.disabled ? currentBgColor.withOpacity(0.28) : currentBgColor;
  }

  void _handleFocus(bool value) {
    widget.onFocus?.call(value);
    _node.requestFocus();
    setState(() {
      _focused = value;
      _fcshvred = value;
      value ? _controller.forward() : _controller.reverse();
    });
  }

  void _tapDown(TapDownDetails details) {
    if (!widget.disabled) {
      _controller.animateTo(1.02);
    }
  }

  void _tapUp(TapUpDetails details) {
    if (!widget.disabled) {
      _controller.forward();
      widget.onClick?.call();
    }
  }

  void enterPress() async {
    if (!widget.disabled) {
      await _controller.reverse();
      await _controller.forward();
      widget.onClick?.call();
    }
  }
}
