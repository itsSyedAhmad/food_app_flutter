import 'package:flutter/material.dart';
import 'package:food_app/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: AppColors.blueBase, width: 2.5),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.font,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,

          style: const TextStyle(color: AppColors.font, fontSize: 18),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: !obscureText
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            hintStyle: const TextStyle(color: AppColors.font, fontSize: 18),
            filled: true,
            fillColor: AppColors.yellow2,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            border: outline,
            enabledBorder: outline,
            focusedBorder: outline.copyWith(
              borderSide: const BorderSide(
                color: AppColors.blueBase,
                width: 2.5,
              ),
            ),
            errorBorder: outline.copyWith(
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            focusedErrorBorder: outline.copyWith(
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
