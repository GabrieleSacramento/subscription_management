import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthenticationEntity extends Equatable {
  final String? uid;
  final String? name;
  final String email;
  final String password;

  const UserAuthenticationEntity({
    required this.email,
    required this.password,
    this.name,
    this.uid,
  });
  factory UserAuthenticationEntity.fromFirebaseUser(User user, {String? name}) {
    return UserAuthenticationEntity(
      uid: user.uid,
      email: user.email ?? '',
      password: '',
      name: name ?? user.displayName,
    );
  }

  @override
  List<Object?> get props => [uid, email, password, name];
}
