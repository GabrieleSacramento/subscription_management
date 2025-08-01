import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_management/src/modules/home/presentation/widgets/home_filled_body_widget.dart';
import 'package:subscription_management/src/modules/home/presentation/widgets/settings_body.dart';
import 'package:subscription_management/src/modules/login/presentation/cubit/user_authentication_cubit.dart';
import 'package:subscription_management/src/routes/router.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

@RoutePage(name: 'HomePageRoute')
class HomePage extends StatefulWidget {
  final String? userName;
  final String? email;

  const HomePage({super.key, this.userName, this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _logoutCubit = GetIt.I.get<UserAuthenticationCubit>();

  final strings = SubscriptionsManagementStrings();
  String? _userName;

  @override
  void initState() {
    _loadUserName();
    super.initState();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();

    if (widget.userName != null) {
      await prefs.setString('userName_${widget.email}', widget.userName!);
      setState(() {
        _userName = widget.userName;
      });
    } else {
      final savedUserName = prefs.getString('userName_${widget.email}');
      setState(() {
        _userName = savedUserName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => _logoutCubit,
        child: Scaffold(
          endDrawer:
              BlocListener<UserAuthenticationCubit, UserAuthenticationState>(
                listener: (context, state) {
                  if (state.isFailure) {
                    showActionSnackBar(context);
                  }
                  if (state.isInitial) {
                    context.router.popUntilRoot();
                    context.router.push(SelectLoginMethodRoute());
                  }
                },
                child: SettingsBody(
                  userName: _userName,
                  onLogout: () {
                    _logoutCubit.logout();
                  },
                ),
              ),
          backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 24.w,
            scrolledUnderElevation: 0.1,
            title: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _userName ?? strings.welcome,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color.fromRGBO(111, 86, 221, 1),
                  ),
                ),
              ),
            ),
            actions: [
              Builder(
                builder:
                    (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 24.w, top: 8.h),
                        child: const Icon(
                          Icons.menu_rounded,
                          color: Color.fromRGBO(111, 86, 221, 1),
                        ),
                      ),
                    ),
              ),
            ],

            backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
            elevation: 0,
          ),
          body: const HomeFilledBodyWidget(),
          floatingActionButton: SizedBox(
            width: 60.w,
            height: 60.h,
            child: FloatingActionButton(
              onPressed: () {
                context.router.navigate(const SelectStreamingPageRoute());
              },
              backgroundColor: const Color.fromRGBO(111, 86, 221, 1),
              child: Icon(
                Icons.add,
                color: const Color.fromRGBO(243, 243, 243, 1),
                size: 48.sp,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

void showActionSnackBar(BuildContext context) {
  const snackBar = SnackBar(
    content: Text(
      'Algo deu errado, tente novamente!',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    backgroundColor: Colors.redAccent,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
