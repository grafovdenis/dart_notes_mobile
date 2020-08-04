import 'package:flutter/material.dart';

class MarkdownText extends StatelessWidget {
  final String content;
  const MarkdownText(this.content, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');
    final List<List<String>> words =
        lines.map((line) => line.split(" ")).toList();

    const _boldStyle =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
    const _italicStyle =
        TextStyle(fontStyle: FontStyle.italic, color: Color(0xffb74093));
    const _defaultStyle = TextStyle(color: Colors.black);

    final RegExp _boldRegExp = RegExp(r"(\*\*\S+\*\*|\_\_\S+\_\_)");
    final RegExp _italicRegExp = RegExp(r"(\*\S+\*|\_\S+\_)");

    final res = words
        .map((line) => line.map((word) => TextSpan(
              text: "${word.replaceAll("_", "").replaceAll("*", "")} ",
              style: (_boldRegExp.firstMatch(word) != null)
                  ? _boldStyle
                  : (_italicRegExp.firstMatch(word) != null)
                      ? _italicStyle
                      : _defaultStyle,
            )))
        .expand((element) => element.toList()..add(TextSpan(text: "\n")))
        .toList();

    return RichText(
      text: TextSpan(children: res),
    );
  }
}
