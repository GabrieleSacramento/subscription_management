import 'package:doso/doso.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subscription_management/src/modules/login/domain/entities/repositories/user_authentication_repository.dart';
import 'package:subscription_management/src/modules/login/domain/entities/user_authentication_entity.dart';
import 'package:subscription_management/src/modules/login/infra/datasource/user_authentication_datasource.dart';

class UserAuthenticationRepositoryImpl implements UserAuthenticationRepository {
  final UserAuthenticationDatasource datasource;

  UserAuthenticationRepositoryImpl({required this.datasource});

  @override
  So<String?, User> signup(UserAuthenticationEntity user) async {
    final result = await datasource.signup(user);
    return result;
  }

  @override
  So<String?, User> signIn(UserAuthenticationEntity user) async {
    final result = await datasource.signIn(user);
    return result;
  }
}
