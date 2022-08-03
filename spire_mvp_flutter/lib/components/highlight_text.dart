import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class HighlightText extends StatelessWidget {
  final String? text;
  final RegExp highlightRegex;
  final TextStyle highlightStyle;
  final TextStyle? nonHighlightStyle;

  const HighlightText({
    Key? key,
    required this.text,
    required this.highlightRegex,
    required this.highlightStyle,
    this.nonHighlightStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) {
      return Text("",
          style: nonHighlightStyle ?? DefaultTextStyle.of(context).style);
    }

    List<TextSpan> spans = [];
    int start = 0;
    while (true) {
      final String? highlight =
          highlightRegex.stringMatch(text!.substring(start));
      if (highlight == null) {
        // no highlight
        spans.add(_normalSpan(text!.substring(start)));
        break;
      }

      final int indexOfHighlight = text!.indexOf(highlight, start);

      if (indexOfHighlight == start) {
        // starts with highlight
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else {
        // normal + highlight
        spans.add(_normalSpan(text!.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    }

    return RichText(
      text: TextSpan(
        style: nonHighlightStyle ?? DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: highlightStyle);
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content);
  }
}

class HighlightDescriptionText extends HighlightText {
  HighlightDescriptionText({
    Key? key,
    required String text,
  }) : super(
          key: key,
          text: text,
          highlightRegex: RegExp(r'Block|Strength|Weak|Vulnerable|Exhaust'),
          highlightStyle: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: getFontSize(16)),
          nonHighlightStyle:
              TextStyle(color: Colors.white, fontSize: getFontSize(16)),
        );
}
