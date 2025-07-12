import 'package:doso/doso.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subscription_management/src/modules/login/domain/entities/repositories/user_authentication_repository.dart';
import 'package:subscription_management/src/modules/login/domain/entities/use_cases/user_authentication_use_case.dart';
import 'package:subscription_management/src/modules/login/domain/entities/user_authentication_entity.dart';

class UserAuthenticationUseCaseImpl implements UserAuthenticationUseCase {
  final UserAuthenticationRepository repository;

  UserAuthenticationUseCaseImpl({required this.repository});

  @override
  So<String?, User> signup(UserAuthenticationEntity user) {
    return repository.signup(user);
  }

  @override
  So<String?, User> signIn(UserAuthenticationEntity user) {
    return repository.signIn(user);
  }
}
