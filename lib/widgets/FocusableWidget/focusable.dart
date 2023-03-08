import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin Focusable<T extends StatefulWidget> on State<T> {
  late FocusNode node;
  bool focused = false;
  late FocusAttachment nodeAttachment;
  @override
  void initState() {
    node = FocusNode();
    node.addListener(_handleFocusChange);
    nodeAttachment = node.attach(context, onKey: handleKeyPress);
    super.initState();
  }

  @override
  void dispose() {
    node.removeListener(_handleFocusChange);
    node.dispose();
    super.dispose();
  }

  Widget buildFocusableWidget(Widget child) {
    nodeAttachment.reparent();
    return GestureDetector(
      onTapDown: tapDown,
      onTapUp: tapUp,
      child: FocusableActionDetector(
        focusNode: node,
        onShowFocusHighlight: handleFocus,
        onShowHoverHighlight: handleHover,
        child: child,
      ),
    );
  }

  void _handleFocusChange() {
    if (node.hasFocus != focused) {
      setState(() {
        focused = node.hasFocus;
      });
    }
  }

  KeyEventResult handleKeyPress(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey.keyId == 4294967309) {
        enterPress();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  void handleFocus(bool value) {
    focused = value;
  }

  void handleHover(bool value) {
    focused = value;
    node.requestFocus();
  }

  void tapDown(TapDownDetails details) {}

  void tapUp(TapUpDetails details) {}

  void enterPress() async {
    handleHover(true);
  }
}
