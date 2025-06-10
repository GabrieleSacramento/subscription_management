import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final IconData? iconButton;
  final Function() onPressed;
  final bool? isLarge;
  final Color? buttonColor;
  final Color? textButtonColor;
  final double? textButtonSize;
  final bool? isTOShowIcon;

  const CustomButton({
    super.key,
    required this.textButton,
    this.iconButton,
    required this.onPressed,
    this.isLarge = false,
    this.buttonColor,
    this.textButtonColor,
    this.textButtonSize,
    this.isTOShowIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          buttonColor ?? const Color.fromRGBO(111, 86, 221, 1),
        ),
        fixedSize: WidgetStateProperty.all<Size>(
          isLarge == true ? Size(double.maxFinite, 40.h) : Size(150.w, 40.h),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textButton,
            style: TextStyle(
              fontSize: textButtonSize ?? 14.h,
              color: textButtonColor ?? const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          if (isTOShowIcon == true)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Icon(
                iconButton,
                size: 16.h,
                color: const Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
        ],
      ),
    );
  }
}
