import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      this.validator,
      this.onSaved,
      required this.labelName,
      this.initialValue,
      this.prefixIcon});

  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String? labelName;
  final String? initialValue;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.2),
      ),
      style: const TextStyle(color: Colors.white),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
