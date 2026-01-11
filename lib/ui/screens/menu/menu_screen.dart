import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/styles/app_color.dart';
import '../../common/title_widget.dart';
import 'widgets/add_new_modal.dart';
import 'widgets/food_item_widget.dart';
import 'dart:convert';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<dynamic> _foodItems = [];

  @override
  void initState() {
    super.initState();
    _loadFoodItems();
  }

  Future<void> _loadFoodItems() async {
    final String response = await rootBundle.loadString(
      'lib/mock_data/mock_data.json',
    );
    final data = json.decode(response);
    setState(() {
      _foodItems = data['foods'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.lightPinkBG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              title: "Thực đơn",
              subtitle: "Bạn đang muốn ăn gì nào?",
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _foodItems.length,
                itemBuilder: (context, index) {
                  final item = _foodItems[index];
                  return FoodItemWidget(
                    itemName: item['name'],
                    itemImageUrl: item['image_url'],
                    itemMealType: item['meal_type_name'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
              child: AddNewModal(),
            ),
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: AppColors.pinkRedSelection,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                offset: Offset(0, 25),
                blurRadius: 50,
                spreadRadius: -12,
              ),
            ],
          ),
          child: Icon(Icons.add, color: AppColors.textWhite),
        ),
      ),
    );
  }
}
