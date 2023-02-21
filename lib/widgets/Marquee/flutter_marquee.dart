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
    this.width = 390,
    this.isButton = false,
    this.maxWidth = double.infinity,
    this.parentFocus,
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
  final double width;
  final bool isButton;
  final double maxWidth;
  final bool? parentFocus;
  @override
  State<FlutterMarquee> createState() => _FlutterMarqueeState();
}

class _FlutterMarqueeState extends State<FlutterMarquee> {
  bool _fcshvred = false;
  bool _isMarqueeOn = false;
  late bool _isOverflow;
  bool _renderMarqueeDelay = false;

  @override
  void initState() {
    super.initState();
  }

  double getBlankSpace(String text, TextStyle style) {
    return TextLayoutHelper.getTextSize(text: text, style: style).width / 2;
  }

  @override
  Widget build(BuildContext context) {
    _isOverflow = TextLayoutHelper.hasTextOverflow(
        text: widget.children,
        style: widget.style,
        maxWidth: widget.isButton ? widget.maxWidth : widget.width);
    return buildMarquee();
  }

  Widget buildMarquee() {
    final textWidth = _calculateTextWidth(widget.children, widget.style);
    if (widget.marqueeOn == 'render') {
      Timer(
          Duration(seconds: widget.marqueeDelay),
          () => {
                setState(() {
                  _renderMarqueeDelay = widget.parentFocus ?? true;
                }),
              });
    }
    return GestureDetector(
      child: FocusableActionDetector(
        onShowHoverHighlight: _handleHover,
        onShowFocusHighlight: _handleHover,
        child: Container(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          width: widget.isButton ? textWidth : widget.width,
          height: 66,
          color: Colors.transparent,
          alignment: Alignment.centerLeft,
          child: (widget.marqueeOn == 'render' &&
                      _isOverflow &&
                      _renderMarqueeDelay) ||
                  (_isMarqueeOn && _isOverflow)
              ? Marquee(
                  text: widget.children,
                  velocity: widget.marqueeSpeed,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: getBlankSpace(widget.children, widget.style),
                  pauseAfterRound: Duration(seconds: widget.marqueeResetDelay),
                  style: widget.style,
                  textDirection: widget.forceDirection == 'ltr'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                )
              : Text(
                  widget.children.replaceAll('', '\u200B'),
                  style: widget.style,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textDirection: widget.forceDirection == 'ltr'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  textAlign: widget.alignment == 'left'
                      ? TextAlign.left
                      : widget.alignment == 'right'
                          ? TextAlign.right
                          : TextAlign.center,
                ),
        ),
      ),
    );
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

  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
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
