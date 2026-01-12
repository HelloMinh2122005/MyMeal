import 'package:flutter/material.dart';
import 'widgets/header_widget.dart';
import 'widgets/card_container.dart';
import 'widgets/footer_gif_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderWidget(),
            const CardContainer(),
            const SizedBox(height: 20),
            const FooterGifWidget(),
          ],
        ),
      ),
    );
  }
}
