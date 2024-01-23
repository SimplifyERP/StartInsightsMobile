import 'package:get_it/get_it.dart';
import 'package:startinsights/Network/my_dio.dart';
import 'package:startinsights/Utils/pref_manager.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<MyDio>(
    () => MyDio(),
  );
  sl.registerLazySingleton<StorageService>(
    () => StorageService(),
  );
}
