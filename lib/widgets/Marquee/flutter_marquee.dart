import 'package:flutter/material.dart';
import 'marquee.dart';
import 'dart:async';

class FlutterMarquee extends StatefulWidget {
  const FlutterMarquee({
    super.key,
    required this.children,
    required this.style,
    this.marqueeOn = 'render',
    this.alignment = 'left',
    this.forceDirection = 'ltr',
    this.marqueeDelay = 1,
    this.marqueeDisabled = false,
    this.marqueeResetDelay = 1,
    this.marqueeSpeed = 60,
    this.scrollAxis = 'horizontal',
    this.width,
  });

  final String children;
  final TextStyle style;
  final String alignment;
  final String forceDirection;
  final int marqueeDelay;
  final bool marqueeDisabled;
  final String marqueeOn;
  final int marqueeResetDelay;
  final double marqueeSpeed;
  final String scrollAxis;
  final double? width;
  @override
  State<FlutterMarquee> createState() => _FlutterMarqueeState();
}

class _FlutterMarqueeState extends State<FlutterMarquee> {
  bool _fcshvred = false;
  bool _isMarqueeOn = false;
  late bool _isOverflow;

  @override
  void initState() {
    super.initState();
  }

  double getBlankSpace(String text, TextStyle style) {
    return TextLayoutHelper.getTextSize(text: text, style: style).width / 2;
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.width ?? MediaQuery.of(context).size.width;
    _isOverflow = TextLayoutHelper.hasTextOverflow(
        text: widget.children, style: widget.style, maxWidth: width);
    if (_isOverflow) {
      if (widget.marqueeOn == 'render') {
        return buildRenderMarquee();
      }
      return buildHoverMarquee();
    }
    return buildHoverMarquee();
  }

  Widget buildHoverMarquee() {
    if (_isMarqueeOn && _isOverflow) {
      return buildRenderMarquee();
    } else {
      return GestureDetector(
        child: FocusableActionDetector(
          onShowHoverHighlight: _handleHover,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 25,
              width: widget.width,
              color: Colors.transparent,
              alignment: widget.alignment == 'left'
                  ? Alignment.topLeft
                  : widget.alignment == 'right'
                      ? Alignment.topRight
                      : Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    widget.children,
                    style: widget.style,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textDirection: widget.forceDirection == 'ltr'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget buildRenderMarquee() {
    return GestureDetector(
        child: FocusableActionDetector(
      onShowHoverHighlight: _handleHover,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 25,
          width: widget.width,
          color: Colors.transparent,
          child: Marquee(
            text: widget.children,
            velocity: widget.marqueeSpeed,
            blankSpace: getBlankSpace(widget.children, widget.style),
            startAfter: widget.marqueeOn == 'render'
                ? Duration(seconds: widget.marqueeDelay)
                : const Duration(seconds: 0),
            pauseAfterRound: Duration(seconds: widget.marqueeResetDelay),
            style: widget.style,
            textDirection: widget.forceDirection == 'ltr'
                ? TextDirection.ltr
                : TextDirection.rtl,
          ),
        ),
      ),
    ));
  }

  void _handleHover(bool value) {
    setState(() {
      _fcshvred = value;
    });
    if (value) {
      Timer(
          Duration(seconds: widget.marqueeDelay),
          () => {
                setState(() {
                  if (_fcshvred) {
                    _isMarqueeOn = true;
                  }
                })
              });
    } else {
      setState(() {
        _isMarqueeOn = false;
      });
    }
  }
}

class TextLayoutHelper {
  TextLayoutHelper._();
  static Size getTextSize({
    required String text,
    required TextStyle style,
    int? maxLines,
    TextDirection? textDirection,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines ?? 1,
      textDirection: textDirection ?? TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  static bool hasTextOverflow({
    required String text,
    required TextStyle style,
    double minWidth = 0,
    double maxWidth = double.infinity,
    int maxLines = 1,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }
}
