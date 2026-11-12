
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String valueKey;
  final String textKey;
  final String returnKey;
  final dynamic selectedValue;
  final String label;
  final Function(dynamic) onChanged;

  const DropdownWidget({
    super.key,
    required this.items,
    required this.valueKey,
    required this.textKey,
    required this.returnKey,
    required this.selectedValue,
    required this.onChanged,
    this.label = 'Seleccione',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<dynamic>(
        decoration: InputDecoration(
          hintText: label,
          fillColor: Colors.grey.shade300,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
        ),
        initialValue: selectedValue,
        isExpanded: true,
        items: items.map((item) {
          return DropdownMenuItem<dynamic>(
            value: item[valueKey],
            child: Text(item[textKey].toString()),
          );
        }).toList(),
        onChanged: (value) {
          final selected = items.firstWhere(
            (item) => item[valueKey] == value,
          );
          onChanged(selected[returnKey]);
        },
      ),
    );
  }
}
