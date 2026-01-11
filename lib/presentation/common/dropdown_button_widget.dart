import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatelessWidget {
  final String title;
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?> onChanged;

  const DropdownButtonWidget({
    super.key,
    required this.title,
    required this.items,
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
        DropdownButton<String>(
          value: selectedItem,
          isExpanded: true,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
