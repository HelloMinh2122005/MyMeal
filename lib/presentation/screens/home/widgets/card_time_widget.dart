import 'package:flutter/material.dart';
import '../../../../core/styles/app_color.dart';
import 'package:intl/intl.dart';

class CardTimeWidget extends StatelessWidget {
  final DateTime currentTime;
  
  const CardTimeWidget({super.key, required this.currentTime});

  @override
  Widget build(BuildContext context) {
    // Format the date and time strings
    String dateString = DateFormat('EEEE, d/M/y', 'vi').format(currentTime);
    dateString = dateString.replaceFirst(
      dateString[0],
      dateString[0].toUpperCase(),
    );
    String timeString = DateFormat('HH:mm:ss').format(currentTime);

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.lightPinkBGCard,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: AppColors.textPink1,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                dateString,
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPink1,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.timer, color: AppColors.textPink1, size: 20),
              const SizedBox(width: 8),
              Text(
                timeString,
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.textPink1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
