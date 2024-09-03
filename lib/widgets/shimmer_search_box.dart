import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSearchBox extends StatelessWidget {
  const ShimmerSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: screenWidth * 0.9,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
