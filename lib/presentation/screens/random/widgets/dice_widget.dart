import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:my_flutter_app/core/animations/bounding_images.dart';
import 'package:my_flutter_app/core/styles/app_color.dart';
import 'package:my_flutter_app/models/type_model.dart';
import 'package:my_flutter_app/presentation/common/meal_type_widget.dart';
import 'package:my_flutter_app/presentation/common/food_item_widget.dart';
import 'package:my_flutter_app/presentation/screens/random/providers/random_provider.dart';
import 'package:my_flutter_app/presentation/screens/random/widgets/result_widget.dart';
import 'package:provider/provider.dart';

class DiceWidget extends StatefulWidget {
  const DiceWidget({super.key});

  @override
  DiceWidgetState createState() => DiceWidgetState();
}

class DiceWidgetState extends State<DiceWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RandomProviderNotifier>().fetchTypes();
      context.read<RandomProviderNotifier>().fetchFoods(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size =
              constraints.maxWidth; // Create Layout first with maxWidth
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: Builder(
                  builder: (context) {
                    final types = context.watch<RandomProviderNotifier>().types;
                    final selectedTypeId = context
                        .watch<RandomProviderNotifier>()
                        .selectedTypeId;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: types.length + 1,
                      itemBuilder: (context, index) {
                        final bool isAllOption = index == 0;
                        final TypeModel? item = isAllOption
                            ? null
                            : types[index - 1];
                        final int? itemId = isAllOption ? null : item?.id;
                        final String itemName = isAllOption
                            ? "📋 Tất cả"
                            : item!.name;
                        final bool isSelected = selectedTypeId == itemId;

                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () {
                              context.read<RandomProviderNotifier>().selectType(
                                itemId,
                              );
                            },
                            child: MealTypeWidget(
                              id: itemId,
                              mealType: itemName,
                              isSelected: isSelected,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  context.read<RandomProviderNotifier>().getRandomFood(
                    context.read<RandomProviderNotifier>().selectedTypeId,
                  );
                },
                child: Container(
                  // Then put inside it a Container with width = maxWidth
                  // We whould get the Square Container with width = max and height = width
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    gradient: AppColors.pinkRedSelection,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
                        // Shadow in all directions
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 12,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: context.watch<RandomProviderNotifier>().isRolling
                        ? Center(
                            child: GifView.asset(
                              'assets/dice_rolling.gif',
                              height: 150,
                              width: 150,
                              frameRate: 30,
                            ),
                          )
                        : context.watch<RandomProviderNotifier>().isRolled
                        ? ResultWidget(
                            name: context
                                .watch<RandomProviderNotifier>()
                                .randomFoodItem!
                                .name,
                            imageUrl: context
                                .watch<RandomProviderNotifier>()
                                .randomFoodItem!
                                .imageUrl,
                          )
                        : BoundingImages(
                            assetUrl: 'assets/dice.png',
                            width: 150,
                            height: 150,
                          ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final foods = context.watch<RandomProviderNotifier>().foods;
                    return ListView.builder(
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        final item = foods[index];
                        return FoodItemWidget(
                          itemId: item.id,
                          itemName: item.name,
                          itemImageUrl: item.imageUrl,
                          itemMealType: item.typeName,
                          isEditable: false,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
