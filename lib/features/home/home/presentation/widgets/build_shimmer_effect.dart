import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerEffect() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          5,
              (index) => Container(
            margin: EdgeInsets.only(bottom: 16),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ),
  );
}