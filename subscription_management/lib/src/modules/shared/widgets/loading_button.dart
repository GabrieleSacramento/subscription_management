import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingButton extends StatelessWidget {
  final bool? isLarge;
  final Color? buttonColor;

  const LoadingButton({super.key, this.isLarge = false, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
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
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
