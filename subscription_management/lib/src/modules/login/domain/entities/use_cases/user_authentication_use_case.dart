import 'package:doso/doso.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subscription_management/src/modules/login/domain/entities/user_authentication_entity.dart';

abstract class UserAuthenticationUseCase {
  So<String?, User> signup(UserAuthenticationEntity user);
  So<String?, User> signIn(UserAuthenticationEntity user);
}
