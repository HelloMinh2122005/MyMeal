import 'package:flutter/material.dart';
import 'widgets/header_widget.dart';
import 'widgets/card_container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          HeaderWidget(),
          CardContainer(),
          // Add more widgets here
        ],
      ),
    );
  }
}
