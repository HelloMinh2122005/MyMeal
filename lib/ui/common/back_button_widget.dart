import 'package:flutter/material.dart';
import '../../core/styles/app_color.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackButtonWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.buttonLightPink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.arrow_back, color: AppColors.iconPink, size: 20),
      ),
    );
  }
}
