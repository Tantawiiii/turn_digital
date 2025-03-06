import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildCategoryButton(String text, String icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}