import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin Focusable<T extends StatefulWidget> on State<T>{
  late FocusNode node;
  bool _focused = false;
  bool fcshvred = false;
  late FocusAttachment nodeAttachment;
  late AnimationController controller;
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

  void _handleFocusChange() {
    if (node.hasFocus != _focused) {
      setState(() {
        _focused = node.hasFocus;
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
    // node.requestFocus();
    _focused = value;
    fcshvred = value;
    value ? controller.forward() : controller.reverse();
  }

  void tapDown(TapDownDetails details) {
    controller.animateTo(1.02);
  }

  void tapUp(TapUpDetails details) {
    controller.forward();
  }

  void enterPress() async {
    await controller.reverse();
    await controller.forward();
  }
}
