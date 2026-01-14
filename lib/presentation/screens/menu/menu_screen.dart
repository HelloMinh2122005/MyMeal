import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/type_model.dart';
import 'package:my_flutter_app/presentation/common/meal_type_widget.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/menu/menu_bloc.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/menu/menu_event.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/menu/menu_state.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_bloc.dart';
import 'package:my_flutter_app/presentation/screens/menu/widgets/search_panel.dart';
import 'package:my_flutter_app/usecase/food_usecase.dart';
import 'package:my_flutter_app/usecase/type_usecase.dart';
import '../../../core/styles/app_color.dart';
import '../../common/title_widget.dart';
import 'widgets/add_new_modal.dart';
import '../../common/food_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();

    context.read<MenuBloc>().add(MenuLoadedStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          } else {
            return _buildMenuContent();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) => BlocProvider(
              create: (_) => MenuModalBloc(
                foodUsecase: context.read<FoodUsecase>(),
                typeUsecase: context.read<TypeUsecase>(),
              ),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: AddNewModal(),
              ),
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

  Widget _buildMenuContent() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            SizedBox(height: 8),
            SearchPanel(),
            SizedBox(height: 5),
            BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                return SizedBox(
                  height: 38,
                  child: state.types.isEmpty
                      ? const Center(
                          child: Text(
                            "Có vẻ thực đơn đang trống, hãy thêm món ăn mới nào!",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.types.length + 1,
                          itemBuilder: (context, index) {
                            final bool isAllOption = index == 0;
                            final TypeModel? item = isAllOption
                                ? null
                                : state.types[index - 1];
                            final int? itemId = isAllOption ? null : item?.id;
                            final String itemName = isAllOption
                                ? "📋 Tất cả"
                                : item!.name;

                            // Logic kiểm tra xem nút này có đang được chọn không
                            // Nếu selectedId == null và đây là nút "Tất cả" -> True
                            // Nếu selectedId == itemId của nút hiện tại -> True
                            final bool isSelected =
                                state.selectedTypeId == itemId;

                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                // Bắt sự kiện Tap
                                onTap: () {
                                  // Gọi hàm selectType bằng cách dispatch event
                                  context.read<MenuBloc>().add(
                                    MenuFilterChanged(
                                      typeId: itemId,
                                      keyword: state.keyword,
                                    ),
                                  );
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
                );
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<MenuBloc, MenuState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.foods.length,
                    itemBuilder: (context, index) {
                      final item = state.foods[index];
                      return FoodItemWidget(
                        itemId: item.id,
                        itemName: item.name,
                        itemImageUrl: item.imageUrl,
                        itemMealType: item.typeName,
                        isEditable: true,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
