import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:subscription_management/src/modules/login/domain/entities/repositories/user_authentication_repository.dart';
import 'package:subscription_management/src/modules/login/domain/entities/use_cases/user_authentication_use_case.dart';
import 'package:subscription_management/src/modules/login/external/user_authentication_datasource_impl.dart';
import 'package:subscription_management/src/modules/login/infra/datasource/user_authentication_datasource.dart';
import 'package:subscription_management/src/modules/login/infra/repositories/user_authentication_repository_impl.dart';
import 'package:subscription_management/src/modules/login/infra/use_cases/user_authentication_use_case_impl.dart';
import 'package:subscription_management/src/modules/login/presentation/cubit/user_authentication_cubit.dart';

Dio dio = Dio();

final setup = GetIt.instance;

Future<void> registerDependencies() async {
  setupDatasources();
  setupRepositories();
  setupUseCases();
  setupCubits();
  setupEntities();
}

void setupDatasources() {
  setup.registerFactory<UserAuthenticationDatasource>(
    () => UserAuthenticationDatasourceImpl(),
  );
}

void setupRepositories() {
  setup.registerFactory<UserAuthenticationRepository>(
    () => UserAuthenticationRepositoryImpl(
      datasource: GetIt.I.get<UserAuthenticationDatasource>(),
    ),
  );
}

void setupUseCases() {
  setup.registerFactory<UserAuthenticationUseCase>(
    () => UserAuthenticationUseCaseImpl(
      repository: GetIt.I.get<UserAuthenticationRepository>(),
    ),
  );
}

void setupCubits() {
  setup.registerFactory<UserAuthenticationCubit>(
    () => UserAuthenticationCubit(
      userAuthenticationUseCase: GetIt.I.get<UserAuthenticationUseCase>(),
    ),
  );
}

void setupEntities() {
  // Register your entities here
}
