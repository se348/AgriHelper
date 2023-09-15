import 'package:flutter/material.dart';

import '../../../features/auth/presentation/widgets/custom_text_field.dart';

class TextFieldWithHeader extends StatelessWidget {
  TextFieldWithHeader(
      {super.key,
      required this.header,
      required this.hintText,
      this.textInputType,
      this.validator,
      required this.textEditingController});
  final String header;
  final String hintText;
  TextInputType? textInputType;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
            type: textInputType,
            validator: validator,
            textEditingController: textEditingController,
            hintText: hintText)
      ],
    );
  }
}
