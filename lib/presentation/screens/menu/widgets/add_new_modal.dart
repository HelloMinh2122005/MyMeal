import 'package:flutter/material.dart';
import '../../../common/dropdown_button_widget.dart';
import '../../../common/small_button_modal.dart';

class AddNewModal extends StatefulWidget {
  const AddNewModal({super.key});

  @override
  State<AddNewModal> createState() => _AddNewModalState();
}

class _AddNewModalState extends State<AddNewModal> {
  final List<String> mealTypes;
  String? selectedItem;

  // TODO: load the meal types from service
  _AddNewModalState()
    : mealTypes = ['Sáng', 'Trưa', 'Tối', 'Ăn Vặt'],
      selectedItem = null;

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
              SmallButtonModal(text: 'Thêm Món'),
            ],
          ),
        ],
      ),
    );
  }
}
