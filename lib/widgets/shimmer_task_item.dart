import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTaskItem extends StatelessWidget {
  const ShimmerTaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.6,
              height: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            Container(
              width: 30, 
              height: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            Container(
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            Container(
              width: 30,
              height: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
