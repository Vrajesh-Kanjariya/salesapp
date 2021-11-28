import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter> inputFormatters;
  final String? labelText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTap;

  const CommonTextFormField({
    Key? key,
    @required this.controller,
    this.inputFormatters = const [],
    @required this.labelText,
    @required this.textInputAction,
    @required this.validator,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap ?? () {},
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabled: true,
        errorMaxLines: 2,
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        fontFamily: 'Poppins',
      ),
    );
  }
}
