import 'package:doso/doso.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subscription_management/src/modules/login/domain/entities/user_authentication_entity.dart';
import 'package:subscription_management/src/modules/login/infra/datasource/user_authentication_datasource.dart';

class UserAuthenticationDatasourceImpl implements UserAuthenticationDatasource {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  So<String?, User> signup(UserAuthenticationEntity user) => Do.tryCatch(
    onTry: () async {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return userCredential.user!;
    },
    onCatch: (exception, stackTrace) {
      return exception.toString();
    },
  );

  @override
  So<String?, User> signIn(UserAuthenticationEntity user) => Do.tryCatch(
    onTry: () async {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return userCredential.user!;
    },
    onCatch: (exception, stackTrace) {
      return exception.toString();
    },
  );
}
