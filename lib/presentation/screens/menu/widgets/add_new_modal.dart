import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_bloc.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_event.dart';
import 'package:my_flutter_app/presentation/screens/menu/bloc/modal/menu_modal_state.dart';
import 'package:my_flutter_app/presentation/screens/menu/widgets/helpers/image_strategy.dart';
import '../../../common/dropdown_button_widget.dart';
import '../../../common/small_button_modal.dart';

class AddNewModal extends StatefulWidget {
  const AddNewModal({super.key});

  @override
  State<AddNewModal> createState() => _AddNewModalState();
}

class _AddNewModalState extends State<AddNewModal> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<MenuModalBloc>().add(LoadedModalStartedEvent(foodId: null));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MenuModalBloc>();

    return BlocListener<MenuModalBloc, MenuModalState>(
      listener: (context, state) {
        if (state is MenuSucessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Thêm món thành công!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<MenuModalBloc, MenuModalState>(
        builder: (context, state) {
          // Show loading indicator while data is being fetched
          if (state is MenuModalLoadingState) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is MenuModalLoadedState) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thêm Món Mới',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _nameController,
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
                      items: state.mealTypes,
                      keySearch: 'name',
                      selectedItem: state.selectedItem,
                      onChanged: (int? value) {
                        context.read<MenuModalBloc>().add(
                          ModalSelectedMealTypeChangedEvent(
                            selectedMealTypeId: value,
                          ),
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
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            bloc.add(ModalImageSelectedEvent());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            bloc.add(ImageRemovedEvent());
                          },
                        ),
                      ],
                    ),
                    imageContainerStrategy(
                      state.itemImageUrl,
                      state.itemImageFile,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallButtonModal(
                          text: 'Hủy',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        SmallButtonModal(
                          text: 'Thêm Món',
                          onPressed: () => bloc.add(
                            ConfirmSelectedEvent(
                              name: _nameController.text,
                              typeId: state.selectedItem.id,
                              id: null,
                              itemImageFile: state.itemImageFile,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is MenuModalErrorState) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          // Default empty container
          return Container(
            padding: const EdgeInsets.all(16),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
      ),
    );
  }
}
