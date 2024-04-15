

import 'package:flutter/material.dart';

class InputDecorations{

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
}){
    return  InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.deepPurple
            )
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.deepPurple,
                width: 2
            )
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
            color: Colors.grey
        ),
        prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: Colors.deepPurple)
            : null
    );
  }



  static TextFormField authTextFormField({
    required String labelText,
    required String hintText,
    final String? helperText,
    final IconData? icon,
    final IconData? suffixIcon,
    final TextInputType? emailAddress,
    final bool obscureText = false,

    required final String formProperty,
    required final Map<String, String> formValues,
}){

    return TextFormField(
      autofocus: false,
      initialValue: "",
      textCapitalization: TextCapitalization.words,
      keyboardType: emailAddress,
      obscureText: obscureText,
      onChanged: (value) => formValues[formProperty] = value,
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