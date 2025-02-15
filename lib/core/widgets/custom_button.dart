import 'package:flutter/material.dart';
import 'package:starzinfinite/core/styles/colors.dart';
import 'package:starzinfinite/core/styles/TextStyle.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color,
        disabledBackgroundColor: kGrey600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        minimumSize: Size(width!, height!),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: blanco)
          : Text(
              text,
              style: semibold(textColor ?? blanco, 16),
            ),
    );
  }
}
