import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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
  // Register your data sources here
}
void setupRepositories() {
  // Register your repositories here
}
void setupUseCases() {
  // Register your use cases here
}
void setupCubits() {
  // Register your cubits here
}
void setupEntities() {
  // Register your entities here
}
