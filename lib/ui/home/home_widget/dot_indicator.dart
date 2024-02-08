import 'package:flutter/material.dart';

class CircularDotIndicator extends StatelessWidget {

  const CircularDotIndicator({super.key, 
    required this.currentIndex,
    required this.dotCount,
    this.dotSize = 10.0,
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.blue,
  });
  final int currentIndex;
  final int dotCount;
  final double dotSize;
  final Color dotColor;
  final Color activeDotColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dotCount, (index) {
        final isActive = index == currentIndex;
        return Container(
          width: dotSize,
          height: dotSize,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeDotColor : dotColor,
          ),
        );
      }),
    );
  }
}
