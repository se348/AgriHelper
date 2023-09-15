import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      this.visible,
      this.suffix,
      this.validator,
      this.type});
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType? type;
  final bool? visible;
  final Widget? suffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: type,
      style: Theme.of(context).textTheme.bodyMedium,
      obscureText: visible != null ? true : false,
      validator: validator,
      decoration: InputDecoration(
          suffixIcon: suffix,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
