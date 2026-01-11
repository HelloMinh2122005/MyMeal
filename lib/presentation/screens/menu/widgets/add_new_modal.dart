import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/dropdown_button_widget.dart';
import '../../../common/small_button_modal.dart';
import '../provider/menu_provider.dart';
import '../../../../models/type_model.dart';

class AddNewModal extends StatefulWidget {
  const AddNewModal({super.key});

  @override
  State<AddNewModal> createState() => _AddNewModalState();
}

class _AddNewModalState extends State<AddNewModal> {
  List<TypeModel> mealTypes = [];
  TypeModel? selectedItem;

  @override
  Widget build(BuildContext context) {
    mealTypes = context.read<MenuProvider>().types;
    if (mealTypes.isEmpty) {
      throw Exception('Meal types list is empty');
    }
    selectedItem ??= mealTypes.first;

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
            'Thêm Món Mới',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 14),
          TextField(
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
              SmallButtonModal(text: 'Thêm Món'),
            ],
          ),
        ],
      ),
    );
  }
}
