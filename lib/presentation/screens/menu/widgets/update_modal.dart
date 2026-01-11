import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/food_details_model.dart';
import 'package:provider/provider.dart';
import '../../../common/dropdown_button_widget.dart';
import '../../../common/small_button_modal.dart';
import '../provider/menu_provider.dart';
import '../../../../models/type_model.dart';

class UpdateModal extends StatefulWidget {
  final int itemId;
  const UpdateModal({super.key, required this.itemId});

  @override
  State<UpdateModal> createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  List<TypeModel> mealTypes = [];
  TypeModel? selectedItem;
  String itemName = '';
  int itemMealId = 0;
  String itemMealType = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItemDetails();
  }

  Future<void> _loadItemDetails() async {
    final provider = context.read<MenuProvider>();
    FoodDetailsModel? item = await provider.fetchFoodItemById(widget.itemId);

    if (!mounted) return;

    if (item != null) {
      selectedItem = await provider.getTypeById(item.typeId);

      if (!mounted) return;

      setState(() {
        itemName = item.name;
        itemMealId = item.typeId;
        itemMealType = item.typeName;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mealTypes = context.read<MenuProvider>().types;
    if (mealTypes.isEmpty) {
      throw Exception('Meal types list is empty');
    }
    selectedItem ??= mealTypes.first;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cập Nhật Món Ăn',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 14),
          TextField(
            controller: TextEditingController(text: itemName),
            onChanged: (value) {
              setState(() {
                itemName = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Tên Món Ăn',
              labelStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          // Dropdown
          DropdownButtonWidget(
            title: 'Chọn Loại Bữa Ăn',
            items: mealTypes,
            keySearch: 'name',
            selectedItem: selectedItem ?? mealTypes.first,
            onChanged: (int? value) {
              setState(() {
                selectedItem = mealTypes.firstWhere(
                  (type) => type.id == value,
                  orElse: () => mealTypes.first,
                );
              });
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallButtonModal(text: 'Hủy'),
              SmallButtonModal(text: 'Cập nhật'),
            ],
          ),
        ],
      ),
    );
  }
}
