import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class FooterGifWidget extends StatelessWidget {
  const FooterGifWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GifView.asset(
        'assets/eating.gif',
        height: 200,
        width: 200,
        frameRate: 30,
      ),
    );
  }
}
