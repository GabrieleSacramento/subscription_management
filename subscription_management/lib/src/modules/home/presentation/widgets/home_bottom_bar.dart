import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromRGBO(111, 86, 221, 1),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.add_circle, color: Colors.white, size: 48.sp),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
