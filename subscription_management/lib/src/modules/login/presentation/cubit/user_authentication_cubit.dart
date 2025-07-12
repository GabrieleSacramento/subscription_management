import 'package:doso/doso.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subscription_management/src/modules/login/domain/entities/use_cases/user_authentication_use_case.dart';
import 'package:subscription_management/src/modules/login/domain/entities/user_authentication_entity.dart';

typedef UserAuthenticationState = Do<Exception, User>;

class UserAuthenticationCubit extends Cubit<Do<Exception, User>> {
  final UserAuthenticationUseCase userAuthenticationUseCase;
  UserAuthenticationCubit({required this.userAuthenticationUseCase})
    : super(const Do.initial());

  Future<void> signup(UserAuthenticationEntity userEntity) async {
    emit(const Do.loading());
    final result = await userAuthenticationUseCase.signup(userEntity);
    final sp = await SharedPreferences.getInstance();
    result.fold(
      onFailure: (exception) {
        emit(Do.failure(Exception(exception)));
      },
      onSuccess: (user) async {
        String? token = await user.getIdToken();
        await sp.setString('token', '$token');
        emit(Do.success(user));
      },
    );
  }

  void signIn(UserAuthenticationEntity userEntity) async {
    emit(const Do.loading());
    final result = await userAuthenticationUseCase.signIn(userEntity);
    final sp = await SharedPreferences.getInstance();
    result.fold(
      onFailure: (exception) {
        emit(Do.failure(Exception(exception)));
      },
      onSuccess: (user) async {
        String? token = await user.getIdToken();
        await sp.setString('token', '$token');
        emit(Do.success(user));
      },
    );
  }

  void logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    emit(const Do.initial());
  }

  void checkAuthentication() async {
    final sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');

    if (token != null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(Do.success(user));
      } else {
        emit(const Do.initial());
      }
    } else {
      emit(const Do.initial());
    }
  }
}
