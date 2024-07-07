import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/commen/app_colors.dart';


class AppTextFromField extends StatefulWidget {
  final String hintText;
  final String? lableText;
  final TextInputType keyboardType;

  final TextEditingController controller;

  const AppTextFromField({
    super.key,
    required this.hintText,
    this.lableText,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  State<AppTextFromField> createState() => _AppTextFromFieldState();
}

class _AppTextFromFieldState extends State<AppTextFromField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        style: TextStyle(color: AppColors.blackText),
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,

          // errorStyle: GoogleFonts.dmSans(
          //   height: 0.1,
          //   fontStyle: FontStyle.normal,
          //   letterSpacing: 0,
          //   color: AppColors.redText,
          //   decoration: TextDecoration.none,
          //   fontWeight: FontWeight.w400,
          //   fontSize: 10,
          // ),
          hintStyle: GoogleFonts.dmSans(
            height: 1.5,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          labelText: widget.lableText,
          labelStyle: GoogleFonts.poppins(
            height: 1.5,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
            color: AppColors.blackText.withOpacity(0.8),
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: AppColors.blackText,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
