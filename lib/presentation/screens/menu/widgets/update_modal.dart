import 'package:flutter/material.dart';
import '../../../common/dropdown_button_widget.dart';
import '../../../common/small_button_modal.dart';

class UpdateModal extends StatefulWidget {
  final int itemId;
  const UpdateModal({super.key, required this.itemId});

  @override
  State<UpdateModal> createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  final List<String> mealTypes = ['Sáng', 'Trưa', 'Tối', 'Ăn Vặt'];
  String? selectedItem;
  String itemName = '';
  String itemMealType = '';

  // Todo: get the item details by id
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            selectedItem: selectedItem ?? mealTypes.first,
            onChanged: (value) {
              setState(() {
                selectedItem = value;
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
