import 'package:flutter/material.dart';
import 'marquee.dart';
import 'dart:async';

class FlutterMarquee extends StatefulWidget {
  const FlutterMarquee({
    super.key,
    required this.children,
    required this.style,
    required this.marqueeOn,
    this.alignment = 'left',
    this.forceDirection = 'ltr',
    this.marqueeDelay = 1,
    this.marqueeDisabled = false,
    this.marqueeResetDelay = 1,
    this.marqueeSpeed = 60,
    this.scrollAxis = 'horizontal',
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
  @override
  State<FlutterMarquee> createState() => _FlutterMarqueeState();
}

class _FlutterMarqueeState extends State<FlutterMarquee> {
  bool _isFocus = false;
  bool _isHover = false;
  bool _isMarqueeOn = false;

  void isHovering() {
    Timer(
        Duration(seconds: widget.marqueeDelay),
        () => {
              if (_isHover || _isFocus)
                {
                  setState(() {
                    _isMarqueeOn = true;
                  })
                }
            });
  }

  void onHover(PointerEvent details) {
    setState(() {
      _isMarqueeOn = false;
    });
    print('enter');
    _isHover = true;
    isHovering();
  }

  void outHover(PointerEvent details) {
    setState(() {
      _isMarqueeOn = false;
    });
    print('exit');
    _isHover = false;
  }

  void setFocus() {
    setState(() {
      _isMarqueeOn = false;
    });
    _isFocus = !_isFocus;
    isHovering();
  }

  double getBlankSpace(String text, TextStyle style) {
    return TextLayoutHelper.getTextSize(text: text, style: style).width / 2;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.marqueeOn == 'render') {
      return buildRenderMarquee();
    }
    return buildHoverMarquee();
  }

  Widget buildHoverMarquee() {
    if (_isMarqueeOn) {
      return buildRenderMarquee();
    } else {
      return Focus(
        child: MouseRegion(
          onEnter: onHover,
          onExit: outHover,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 25,
              color: _isHover || _isFocus ? Colors.blue : Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign:widget.alignment=='left'?TextAlign.left:TextAlign.right,
                    widget.children,
                    style: widget.style,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textDirection: widget.forceDirection=='ltr'?TextDirection.ltr:TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),
        ),
        onFocusChange: (focused) {
          setFocus();
        },
      );
    }
  }

  Widget buildRenderMarquee() {
    return Focus(
      child: MouseRegion(
        onEnter: onHover,
        onExit: outHover,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            height: 25,
            color: _isHover || _isFocus ? Colors.blue : Colors.transparent,
            child: Marquee(
              text: widget.children,
              velocity: widget.marqueeSpeed,
              blankSpace: getBlankSpace(widget.children, widget.style),
              pauseAfterRound: Duration(seconds: widget.marqueeResetDelay),
              startAfter: Duration(seconds: widget.marqueeDelay),
              style: widget.style,
              textDirection: widget.forceDirection=='ltr'?TextDirection.ltr:TextDirection.rtl,
            ),
          ),
        ),
      ),
      onFocusChange: (focused) {
        setFocus();
      },
    );
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
