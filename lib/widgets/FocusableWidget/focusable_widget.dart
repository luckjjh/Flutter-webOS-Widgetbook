import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusableWidget extends StatefulWidget {
  const FocusableWidget({
    super.key,
    this.backgroundOpacity = 'opaque',
    this.animaterable = true,
    required this.child,
    this.minWidth = true,
    this.onFocus,
    this.onClick,
  });

  final bool animaterable;
  final Widget child;
  final bool minWidth;
  final String backgroundOpacity;
  final Function? onFocus;
  final VoidCallback? onClick;
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
      height: 54,
      padding: const EdgeInsets.only(left: 24,right: 24),
      constraints: BoxConstraints(
        maxWidth: 450,
        minWidth: widget.minWidth ? 150 : 54,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: getBaseBgColor()),
      child: widget.child,
    );
  }

  Color getBaseBgColor() {
    if (widget.backgroundOpacity == 'opaque') {
      return _fcshvred ? Colors.white : Colors.grey;
    } else {
      return _fcshvred ? Colors.white : Colors.transparent;
    }
  }

  void _handleFocus(bool value) {
    widget.onFocus?.call(value);
    setState(() {
      _fcshvred = value;
      value ? _controller.forward() : _controller.reverse();
    });
  }

  void _tapDown(TapDownDetails details) {
    _controller.animateTo(1.02);
  }

  void _tapUp(TapUpDetails details) {
    _controller.forward();
    widget.onClick?.call();
  }

  void enterPress() async {
    await _controller.reverse();
    await _controller.forward();
    widget.onClick?.call();
  }
}
