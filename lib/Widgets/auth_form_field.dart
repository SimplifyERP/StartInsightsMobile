import 'package:flutter/material.dart';
import 'package:startinsights/Utils/FontSizes.dart';
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
  final bool isMandatory;
  final double radius;

  final bool mBorderView;
  final bool mImageView;
  final bool mIncreshHeight;
  final double mTop;
  final double mBottom;

  final Color? borderColor;
  final Color? viewbgColor;

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
    this.isMandatory = false,
    this.mBorderView = true,
    this.mImageView = true,
    this.mIncreshHeight = false,
    this.mTop = 15,
    this.mBottom = 15,
    this.borderColor = mGreyFour,
    this.viewbgColor = mLightColorOne,
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
        style: const TextStyle(
            fontSize: mSizeThree,
            fontFamily: 'OpenSauceSansRegular',
            color: mBlackOne),
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
            counterText: "",
            label: isMandatory
                ? RichText(
                    text: TextSpan(
                        text: labelText,
                        style: const TextStyle(
                            color: mGreyEigth,
                            fontFamily: 'OpenSauceSansRegular',
                            fontSize: mSizeTwo),
                        children: const [
                          TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'OpenSauceSansRegular',
                                  fontSize: mSizeTwo))
                        ]),
                  )
                : RichText(
                    text: TextSpan(
                      text: labelText,
                      style: const TextStyle(
                          color: mGreyEigth,
                          fontFamily: 'OpenSauceSansRegular',
                          fontSize: mSizeTwo),
                    ),
                  ),
            labelStyle: const TextStyle(
                fontSize: mSizeTwo,
                fontFamily: 'OpenSauceSansRegular',
                color: mGreyEigth),
            hintText: isMandatory ? "${hintText} *" : hintText,
            alignLabelWithHint: true,
            hintStyle: const TextStyle(
              color: mGreyEigth,
            ),
            isDense: true, // Added this
            floatingLabelBehavior: FloatingLabelBehavior.never,
            floatingLabelStyle: const TextStyle(
              color: Colors.blue,
              fontSize: mSizeTwo,
              fontFamily: 'OpenSauceSansRegular',
            ),
            // floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.fromLTRB(10, mTop, 10, mBottom),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: borderColor!, width: 1)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor!, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 1, color: borderColor!)),
            fillColor: viewbgColor,
            filled: true));
  }

  Widget mMandatoryView() {
    return RichText(
      text: TextSpan(
          text: labelText,
          style: TextStyle(
              color: mGreyEigth,
              fontFamily: 'OpenSauceSansRegular',
              fontSize: mSizeTwo),
          children: [
            TextSpan(
                text: ' *',
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'OpenSauceSansRegular',
                    fontSize: mSizeTwo))
          ]),
    );
  }
}
