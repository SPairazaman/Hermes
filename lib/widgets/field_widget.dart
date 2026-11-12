import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  int maxLines;
  String? Function(String?)? validator;
  VoidCallback? function;

  FieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.maxLines=1,
    required this.validator,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        onTap: function,
        readOnly: function != null ? true : false,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
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
        validator: validator,
      ),

    );
  }
}