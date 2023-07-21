import 'package:ifinapp/common/common.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.foregroundColor,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: padding,
        foregroundColor: foregroundColor ?? Colors.white,
        backgroundColor: backgroundColor ?? primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
