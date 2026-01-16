import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ResultWidget({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // 1. TweenAnimationBuilder handles the animation automatically on load
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1), // Animate scale from 0% to 100%
      duration: const Duration(milliseconds: 800), // Duration of the "pop"
      curve: Curves.elasticOut, // This creates the "WOW" bouncy effect
      builder: (context, double value, child) {
        return Transform.scale(scale: value, child: child);
      },
      // 2. Pass your original Column as the 'child' to optimize performance
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageUrl, width: 200, height: 140, fit: BoxFit.cover),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
