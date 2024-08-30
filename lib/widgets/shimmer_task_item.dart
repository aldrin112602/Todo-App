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
        padding: const EdgeInsets.symmetric(vertical: 12.0), // Adjusted for larger vertical space
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.6, // Adjust the width to take up more space
              height: 30, // Adjust the height for better visibility
              color: Colors.white,
            ),
            const SizedBox(width: 20), // Increased spacing for better layout
            Container(
              width: 30, // Increased width for larger shimmer squares
              height: 30, // Increased height to match
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
