import 'package:flutter/material.dart';
import 'package:my_flutter_app/core/config/cloudinary_config.dart';
import 'package:my_flutter_app/core/services/impl/media_service_impl.dart';
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
  String itemImageUrl = '';

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
          const Text(
            'Thêm Món Mới',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          TextField(
            decoration: InputDecoration(
              labelText: 'Tên Món Ăn',
              labelStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
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
          Row(
            children: [
              Expanded(
                child: const Text(
                  'Hình ảnh',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.blue),
                onPressed: () async {
                  String? imageUrl = await MediaServiceImpl(
                    CloudinaryConfig(),
                  ).captureImageWithCamera();
                  if (imageUrl != null) {
                    setState(() {
                      itemImageUrl = imageUrl;
                    });
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  setState(() {
                    itemImageUrl = '';
                  });
                },
              ),
            ],
          ),
          if (itemImageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.network(itemImageUrl, fit: BoxFit.cover),
            )
          else
            const Image(image: AssetImage('assets/image-holder.png')),
          const SizedBox(height: 20),
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
