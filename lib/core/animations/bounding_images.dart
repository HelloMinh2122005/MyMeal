import 'package:flutter/material.dart';

class BoundingImages extends StatefulWidget {
  final String assetUrl;
  final double width;
  final double height;

  const BoundingImages({
    super.key,
    required this.assetUrl,
    required this.width,
    required this.height,
  });

  @override
  State<BoundingImages> createState() => _BoundingImagesState();
}

class _BoundingImagesState extends State<BoundingImages>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // How long one bounce takes
      vsync: this,
    )..repeat(reverse: true); // Repeat indefinitely, reversing direction

    // 2. Define the range of motion (0 to -20 pixels up)
    _animation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooths the top and bottom of the bounce
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Always dispose controllers!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // 3. Use AnimatedBuilder to rebuild just the transform when value changes
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              0,
              _animation.value,
            ), // Move Y-axis by animation value
            child: child,
          );
        },
        // 4. Pass your original widget as the 'child' so it doesn't rebuild every frame
        child: Image(
          image: AssetImage(widget.assetUrl),
          height: widget.height,
          width: widget.width,
        ),
      ),
    );
  }
}
