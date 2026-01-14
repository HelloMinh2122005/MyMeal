import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/styles/app_color.dart';
import '../bloc/menu/menu_bloc.dart';
import '../bloc/menu/menu_event.dart';
import '../bloc/menu/menu_state.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                return TextField(
                  controller: _searchController,
                  cursorColor: AppColors.textPink1,
                  onChanged: (value) {
                    context.read<MenuBloc>().add(
                      MenuFilterChanged(
                        typeId: state.selectedTypeId,
                        keyword: value,
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm món ăn...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Arial',
                      color: AppColors.mutedText,
                    ),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFFB64B6)),
                    filled: true,
                    fillColor: AppColors.white80,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: AppColors.fccee8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: AppColors.fccee8),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: AppColors.fccee8),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
