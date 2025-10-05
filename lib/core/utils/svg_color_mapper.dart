import 'package:flutter/material.dart' show Color, Colors;
import 'package:flutter_svg/svg.dart' show ColorMapper;

class SvgColorMapper extends ColorMapper {
  const SvgColorMapper();

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    if (color == const Color(0xFFFF0000)) {
      return Colors.blue;
    }
    if (color == const Color(0xFF00FF00)) {
      return Colors.yellow;
    }
    return color;
  }
}
