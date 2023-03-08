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
    this.height = 72,
    this.isButton = false,
    this.maxWidth = double.infinity,
    this.parentFocus = true,
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
  final double height;
  final bool isButton;
  final double maxWidth;
  final bool parentFocus;
  @override
  State<FlutterMarquee> createState() => _FlutterMarqueeState();
}

class _FlutterMarqueeState extends State<FlutterMarquee> {
  bool _fcshvred = false;
  bool _isMarqueeOn = false;
  bool _renderMarqueeDelay = false;
  Timer? _timer;
  late bool _isOverflow;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
      _timer = null;
    }
    if (widget.parentFocus) {
      _timer = Timer(const Duration(seconds: 1), () {
        setState(() {
          _renderMarqueeDelay = widget.parentFocus;
        });
      });
    } else {
      _timer?.cancel();
      _timer = null;
      setState(() {
        _renderMarqueeDelay = widget.parentFocus;
      });
    }

    return GestureDetector(
      child: FocusableActionDetector(
        onShowHoverHighlight: _handleHover,
        onShowFocusHighlight: _handleHover,
        child: Container(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          width: widget.isButton ? textWidth : widget.width,
          height: widget.height,
          color: Colors.transparent,
          alignment: Alignment.centerLeft,
          child: (widget.marqueeOn == 'render' &&
                      _isOverflow &&
                      _renderMarqueeDelay) ||
                  (widget.marqueeOn == 'hover' && _isMarqueeOn && _isOverflow)
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
    if (!widget.isButton) {
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

  double getBlankSpace(String text, TextStyle style) {
    return TextLayoutHelper.getTextSize(text: text, style: style).width / 2;
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
