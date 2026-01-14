import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/core/config/cloudinary_config.dart';
import 'package:my_flutter_app/core/services/impl/media_service_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_bloc.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_event.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_state.dart';
import 'package:my_flutter_app/presentation/screens/menu/widgets/helpers/image_strategy.dart';
import '../../../common/dropdown_button_widget.dart';
import '../../../common/small_button_modal.dart';

class UpdateModal extends StatefulWidget {
  final int itemId;
  const UpdateModal({super.key, required this.itemId});

  @override
  State<UpdateModal> createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  @override
  void initState() {
    super.initState();

    context.read<MenuModalBloc>().add(
      LoadedModalStarted(foodId: widget.itemId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuModalBloc, MenuModalState>(
      builder: (context, state) {
        // Show loading indicator while data is being fetched
        if (state.isLoading || state.types.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
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
              const Text(
                'Cập Nhật Món Ăn',
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
                items: state.types,
                keySearch: 'name',
                selectedItem: state.selectedItem ?? state.types.first,
                onChanged: (int? value) {
                  context.read<MenuModalBloc>().add(
                    ModalSelectedMealTypeChanged(selectedMealTypeId: value),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: const Text(
                      'Hình ảnh',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.blue),
                    onPressed: () async {
                      XFile? newImageSelected = await MediaServiceImpl(
                        CloudinaryConfig(),
                      ).captureImageWithCamera();
                      if (newImageSelected != null) {
                        context.read<MenuModalBloc>().add(
                          ModalImageSelected(imageFile: newImageSelected),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      context.read<MenuModalBloc>().add(
                        ModalImageSelected(imageFile: null),
                      );
                    },
                  ),
                ],
              ),
              imageContainerStrategy(state.imageUrl, state.imageFile),
              const SizedBox(height: 20),
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
      },
    );
  }
}
