import 'package:flutter/material.dart';
import '../../core/styles/app_color.dart';

class MealTypeWidget extends StatelessWidget {
  final int id;
  final String mealType;
  final bool isSelected;

  const MealTypeWidget({
    super.key,
    required this.id,
    required this.mealType,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: isSelected ? AppColors.pinkRedSelection : null,
        color: isSelected ? null : AppColors.lightGrayBG,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        mealType,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
