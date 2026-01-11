import 'card_time_widget.dart';
import 'package:flutter/material.dart';
import 'card_meal_widget.dart';
import 'two_cards_widget.dart';
import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';

class CardContainer extends StatefulWidget {
  const CardContainer({super.key});

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  late DateTime _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi_VN', null);
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,

        children: [
          CardTimeWidget(currentTime: _currentTime),
          SizedBox(height: 20),
          CardMealWidget(currentTime: _currentTime),
          SizedBox(height: 20),
          TwoCardsWidget(),
        ],
      ),
    );
  }
}
