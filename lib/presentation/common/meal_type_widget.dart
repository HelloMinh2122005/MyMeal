import 'package:flutter/material.dart';
import '../../core/styles/app_color.dart';

class MealTypeWidget extends StatelessWidget {
  final int? id;
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
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.pinkRedSelection : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          mealType,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textPink1,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
