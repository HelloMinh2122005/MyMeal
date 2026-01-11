import 'package:flutter/material.dart';
import '../../../core/styles/app_color.dart';
import '../../common/title_widget.dart';

class RandomScreen extends StatelessWidget {
  const RandomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.lightPinkBG),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              title: "Quay tay món ăn",
              subtitle: "Hãy để ứng dụng chọn giúp bạn nhé! 🎲",
            ),
          ],
        ),
      ),
    );
  }
}
