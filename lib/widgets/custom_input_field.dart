import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? emailAddress;
  final bool obscureText;

  const CustomInputField({
    super.key,
    this.labelText,
    this.hintText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.emailAddress,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      initialValue: "",
      textCapitalization: TextCapitalization.words,
      keyboardType: emailAddress,
      obscureText: obscureText,
      onChanged: (value) {
        print("value: $value");
      },
      validator: (value) {
        if (value == null) return "Requerido";
        return value.length < 3 ? "Minimo 3 letras" : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
        icon: icon == null ? null : Icon(icon),
      ),
    );
  }
}
