import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:subscription_management/src/routes/router.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

class SettingsBody extends StatelessWidget {
  final VoidCallback? onLogout;
  final strings = SubscriptionsManagementStrings();

  final String? userName;

  SettingsBody({super.key, this.userName, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 24.w),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(111, 86, 221, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
                  child: Icon(
                    Icons.person,
                    size: 30.sp,
                    color: const Color.fromRGBO(111, 86, 221, 1),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  userName ?? strings.welcome,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(243, 243, 243, 1),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.subscriptions_outlined,
                  title: strings.mySubscriptions,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.add_circle_outline,
                  title: strings.addSubscription,
                  onTap: () {
                    Navigator.pop(context);
                    context.router.navigate(const SelectStreamingPageRoute());
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(16.w),
            child: _buildDrawerItem(
              icon: Icons.logout,
              title: strings.logout,
              onTap: () {
                Navigator.pop(context);
                onLogout?.call();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color.fromRGBO(111, 86, 221, 1),
        size: 24.sp,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: const Color.fromRGBO(77, 77, 97, 1),
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
    );
  }
}
