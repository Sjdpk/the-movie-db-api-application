import 'package:flutter/material.dart';

// @desc text widget with custom values
displayText(
  String data, {
  double? fontSize,
  letterSpacing,
  wordSpacing,
  double leftPadding = 0.0,
  topPadding = 0.0,
  rightPadding = 0.0,
  bottomPadding = 0.0,
  String? fontFamily,
  FontWeight? fontWeight,
}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      leftPadding + 0.0,
      topPadding + 0.0,
      rightPadding + 0.0,
      bottomPadding + 0.0,
    ),
    child: Text(
      data,
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
      ),
    ),
  );
}
