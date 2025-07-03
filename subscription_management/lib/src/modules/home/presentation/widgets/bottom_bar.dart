import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8.0,
      color: const Color.fromRGBO(77, 77, 97, 1),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.home_outlined,
                color: const Color.fromRGBO(243, 243, 243, 1),
                size: 24.sp,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(111, 86, 221, 1),
                child: Icon(
                  Icons.add,
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  size: 28.sp,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.settings_outlined,
                color: const Color.fromRGBO(243, 243, 243, 1),
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
