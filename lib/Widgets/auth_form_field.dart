import 'package:flutter/material.dart';
import 'package:startinsights/Utils/MyColor.dart';

class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? labelText;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String imageicon;
  final String suffiximageicon;
  final Color? backgroundColor;
  final Color textColor;
  final Color? labelColor;
  final Color? cursorColor;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool mreadOnly;
  final double radius;
  final bool mBorderView;
  final bool mImageView;

  const AuthFormField({
    Key? key,
    required this.controller,
    this.validator,
    this.onTap,
    this.labelText,
    required this.keyboardType,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.backgroundColor,
    this.maxLines,
    this.enabled = true,
    this.textColor = mBlackColor,
    this.labelColor = kGray,
    this.cursorColor,
    this.maxLength,
    this.textInputAction,
    this.radius = 30,
    this.imageicon = 'assets/ic_maillogin.png',
    this.suffiximageicon = 'assets/ic_maillogin.png',
    this.autofocus = false,
    this.mreadOnly = false,
    this.mBorderView = true,
    this.mImageView = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: autofocus,
        textInputAction: textInputAction,
        maxLength: maxLength,
        cursorColor: cursorColor,
        enabled: enabled,
        maxLines: maxLines,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: mreadOnly,
        obscureText: obscureText,
        style: TextStyle(
            fontSize: 16, fontFamily: 'OpenSansRegular', color: textColor),
        decoration: InputDecoration(
            counterText: "",
            labelText: labelText,
            labelStyle: const TextStyle(
                fontSize: 15, fontFamily: 'OpenSansRegular', color: kGray),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: kGray,
            ),
            isDense: true, // Added this

            floatingLabelStyle: const TextStyle(color: Colors.blue),
            // floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kTextBorder, width: 1)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kTextBorder, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 1, color: kTextBorder))));
  }
}
