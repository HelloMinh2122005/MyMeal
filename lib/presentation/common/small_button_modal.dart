import 'package:flutter/material.dart';
import '../../core/styles/app_color.dart';

class SmallButtonModal extends StatelessWidget {
  final String text;
  const SmallButtonModal({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Call service to add new item here
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          gradient: AppColors.pinkRedSelection,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
