import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/food_model_item.dart';
import 'package:my_flutter_app/models/type_model.dart';
import 'package:my_flutter_app/presentation/common/meal_type_widget.dart';
import '../../../core/styles/app_color.dart';
import '../../common/title_widget.dart';
import 'widgets/add_new_modal.dart';
import 'widgets/food_item_widget.dart';
import 'package:provider/provider.dart';
import 'provider/menu_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();

    // Use WidgetsBinding to ensure context is available
    // addPostFrameCallback: called after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuProvider>().fetchTypes();
      context.read<MenuProvider>().fetchFoods(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MenuProvider>(
        builder: (context, menuProvider, child) {
          if (menuProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (menuProvider.errorMessage != null) {
            return Center(child: Text(menuProvider.errorMessage!));
          } else {
            List<FoodModelItem> foodItems = menuProvider.foods;
            List<TypeModel> mealTypes = menuProvider.types;
            int? selectedId = menuProvider.selectedTypeId;

            return _buildMenuContent(foodItems, mealTypes, selectedId);
          }
        },
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

  Widget _buildMenuContent(
    List<FoodModelItem> foodItems,
    List<TypeModel> mealTypes,
    int? selectedId,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: AppColors.lightPinkBG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: "Thực đơn", subtitle: "Bạn đang muốn ăn gì nào?"),
          SizedBox(height: 8),
          SizedBox(
            height: 38,
            child: mealTypes.isEmpty
                ? const Center(
                    child: Text(
                      "Có vẻ thực đơn đang trống, hãy thêm món ăn mới nào!",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mealTypes.length + 1,
                    itemBuilder: (context, index) {
                      final bool isAllOption = index == 0;
                      final TypeModel? item = isAllOption
                          ? null
                          : mealTypes[index - 1];
                      final int? itemId = isAllOption ? null : item?.id;
                      final String itemName = isAllOption
                          ? "📋 Tất cả"
                          : item!.name;

                      // Logic kiểm tra xem nút này có đang được chọn không
                      // Nếu selectedId == null và đây là nút "Tất cả" -> True
                      // Nếu selectedId == itemId của nút hiện tại -> True
                      final bool isSelected = selectedId == itemId;

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          // Bắt sự kiện Tap
                          onTap: () {
                            // Gọi hàm selectType trong Provider
                            context.read<MenuProvider>().selectType(itemId);
                          },
                          child: MealTypeWidget(
                            id: itemId,
                            mealType: itemName,
                            isSelected:
                                isSelected, // Truyền trạng thái động vào
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final item = foodItems[index];
                return FoodItemWidget(
                  itemId: item.id,
                  itemName: item.name,
                  itemImageUrl: item.imageUrl,
                  itemMealType: item.typeName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
