import 'package:flutter/material.dart';
import '../../../../core/styles/app_color.dart';
import 'package:provider/provider.dart';
import '../provider/menu_provider.dart';

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
            child: TextField(
              controller: _searchController,
              cursorColor: AppColors.textPink1,
              onChanged: (value) {
                context.read<MenuProvider>().selectType(
                  context.read<MenuProvider>().selectedTypeId,
                  value,
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
            ),
          ),
        ],
      ),
    );
  }
}
