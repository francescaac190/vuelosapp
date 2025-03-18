import 'package:flutter/material.dart';

import '../cores.dart';

TextFormField CustomTextFormField(
    TextEditingController textController,
    TextInputType textInputType,
    TextCapitalization textCap,
    bool obscureText,
    String hintText,
    String? Function(String?)? validator,
    Widget? suffix) {
  return TextFormField(
    controller: textController,
    keyboardType: textInputType,
    textCapitalization: textCap,
    obscureText: obscureText,
    autocorrect: false,
    onTapOutside: (event) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    style: regular(blackBeePay, 16),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      hintText: hintText,
      constraints: BoxConstraints(
        maxHeight: 50,
      ),
      hintStyle: regular(gris2, 15),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: background2,
      suffixIcon: suffix,
    ),
    validator: validator,
  );
}

TextFormField CustomTextFormFieldUnderline(
  TextEditingController textController,
  TextInputType textInputType,
  TextCapitalization textCap,
  bool obscureText,
  bool autoCorrect,
  String? Function(String?)? validator,
  String? Function(String?)? onChanged,
) {
  return TextFormField(
    controller: textController,
    keyboardType: textInputType,
    textCapitalization: textCap,
    obscureText: obscureText,
    autocorrect: autoCorrect,
    onTapOutside: (event) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    style: regular(blackBeePay, 16),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      constraints: BoxConstraints(
          // maxHeight: 40,
          ),
      hintStyle: regular(gris2, 15),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: gris5),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: gris5),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: gris5),
      ),
    ),
    validator: validator,
    onChanged: onChanged,
  );
}

void Mensaje(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: blanco,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      margin: EdgeInsets.all(10),
      content: Text(
        mensaje,
        style: medium(blackBeePay, 15),
      ),
    ),
  );
}

void MensajeError(BuildContext context, String mensaje) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: rojo,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      content: Text(
        mensaje,
        style: medium(blanco, 15),
      ),
    ),
  );
}
