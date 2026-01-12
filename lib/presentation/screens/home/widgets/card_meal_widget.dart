import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/styles/app_color.dart';

class NavButton extends StatelessWidget {
  final VoidCallback? onTap;

  const NavButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.textWhite.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                'Chọn món ăn hôm nay',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: AppColors.textWhite,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward, color: AppColors.textWhite, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class CardMealWidget extends StatelessWidget {
  final DateTime currentTime;
  final List<String> meals;

  const CardMealWidget({
    super.key,
    required this.currentTime,
    this.meals = const ['Bữa sáng', 'Bữa trưa', 'Bữa tối'],
  });

  String getMealType(DateTime time) {
    final hour = time.hour;
    if (hour < 9) {
      return meals[0];
    } else if (hour < 14) {
      return meals[1];
    } else {
      return meals[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.orangeBGCard,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -4,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.coffee,
                              color: AppColors.textWhite,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Đến giờ...',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: AppColors.textWhite,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          getMealType(currentTime),
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.textWhite,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),
                    Text('🥰', style: TextStyle(fontSize: 30)),
                  ],
                ),
                SizedBox(height: 8),
                NavButton(
                  onTap: () {
                    context.push('/menu');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
