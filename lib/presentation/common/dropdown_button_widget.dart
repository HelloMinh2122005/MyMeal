import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final dynamic selectedItem;
  final String? keySearch;
  final ValueChanged<int?> onChanged;

  const DropdownButtonWidget({
    super.key,
    required this.title,
    required this.items,
    required this.keySearch, // The key to display from the item, for example 'name' => display item.name
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        DropdownButton<int>(
          value: selectedItem?.id,
          isExpanded: true,
          items: items.map<DropdownMenuItem<int>>((dynamic value) {
            String displayText;
            if (value is Map) {
              displayText = value[keySearch!] ?? value.toString();
            } else {
              displayText = (keySearch == 'name' && value.name != null)
                  ? value.name
                  : value.toString();
            }
            return DropdownMenuItem<int>(
              value: value.id,
              child: Text(displayText),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
