import 'package:flutter/material.dart';
import 'package:my_flutter_app/presentation/screens/random/widgets/dice_widget.dart';
import '../../../core/styles/app_color.dart';
import '../../common/title_widget.dart';

class RandomScreen extends StatelessWidget {
  const RandomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: AppColors.lightPinkBG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: "Quay tay món ăn",
                subtitle: "Hãy để ứng dụng chọn giúp bạn nhé! 🎲",
              ),
              SizedBox(height: 30),
              DiceWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
