import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart' as validator;
import 'package:subscription_management/src/modules/login/domain/entities/user_authentication_entity.dart';
import 'package:subscription_management/src/modules/login/presentation/cubit/user_authentication_cubit.dart';
import 'package:subscription_management/src/modules/shared/widgets/custom_app_bar.dart';
import 'package:subscription_management/src/modules/shared/widgets/custom_button.dart';
import 'package:subscription_management/src/modules/shared/widgets/custom_form.dart';
import 'package:subscription_management/src/modules/shared/widgets/loading_button.dart';
import 'package:subscription_management/src/routes/router.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

@RoutePage(name: 'SignupPageRoute')
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final strings = SubscriptionsManagementStrings();
  final _signupCubit = GetIt.I.get<UserAuthenticationCubit>();

  bool isPasswordVisible = false;
  _navigateToHomePage(String? userName) {
    context.pushRoute(HomePageRoute(userName: null));
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void clearForm() {
    _formKey.currentState?.reset();
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _signupCubit,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              appBarTitle: strings.enter,
              isBackButtonVisible: true,
              backgroundColor: Colors.white,
              appBarTitleColor: const Color.fromRGBO(111, 86, 221, 1),
              appBarIconColor: const Color.fromRGBO(111, 86, 221, 1),
              onBackButtonPressed: () => Navigator.pop(context),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 32.w,
                  top: 24.h,
                  bottom: 32.h,
                ),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: CustomForm(
                              isMandatory: true,
                              hintText: strings.name,
                              controller: nameController,
                              label: strings.name,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return strings.thisFieldIsRequired;
                                }
                                return null;
                              },
                            ),
                          ),
                          CustomForm(
                            isMandatory: true,
                            controller: emailController,
                            hintText: 'Email',
                            label: 'Email',
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return strings.thisFieldIsRequired;
                              }
                              if (!validator.isEmail(text)) {
                                return 'Email inválido';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
                            child: CustomForm(
                              isMandatory: true,
                              obscurePassword: isPasswordVisible,
                              hintText: strings.password,
                              controller: passwordController,
                              label: strings.password,
                              suffixIcon: GestureDetector(
                                onTap:
                                    () => setState(
                                      () =>
                                          isPasswordVisible =
                                              !isPasswordVisible,
                                    ),
                                child: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return strings.thisFieldIsRequired;
                                }
                                if (text.length < 8) {
                                  return strings.passwordMustBeAtLeast;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocConsumer<
                      UserAuthenticationCubit,
                      UserAuthenticationState
                    >(
                      listener: (context, state) async {
                        if (state.isFailure) {
                          showActionSnackBarError(context);
                        } else if (state.isSuccess) {
                          final email = emailController.text;

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final userName =
                              prefs.getString('userName_$email') ??
                              'Usuário não identificado';

                          _navigateToHomePage(userName);
                          clearForm();
                        }
                      },

                      builder: (context, state) {
                        return state.isLoading
                            ? const LoadingButton(isLarge: true)
                            : CustomButton(
                              textButton: strings.enter,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _signupCubit.signup(
                                    UserAuthenticationEntity(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              isLarge: true,
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showActionSnackBarError(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        strings.wasNotPossibleToCreateAnAccount,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromRGBO(111, 86, 221, 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
