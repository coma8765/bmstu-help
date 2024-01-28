import 'package:bmstu_help/src/services/http/dio_http.dart';
import 'package:bmstu_help/src/services/http/http.dart';
import 'package:bmstu_help/src/services/logging/fimber_logging.dart';
import 'package:bmstu_help/src/services/logging/logging.dart';
import 'package:bmstu_help/src/services/permission/permission_handler_permission_service.dart';
import 'package:bmstu_help/src/services/permission/permission_service.dart'
    show PermissionService;
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt
    // Logging service
    ..registerFactoryParam<Logging, String, void>(
      (String name, _) => FimberLogging(name),
    )

    // Permission handler
    ..registerLazySingleton<PermissionService>(
      PermissionHandlerPermissionService.new,
    )

    // HTTP service
    ..registerLazySingleton<HTTP>(() => DioHTTP(Dio()));
}
