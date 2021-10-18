import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_star/core/session/credential_guard.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:movie_star/core/di/injection.dart' as di;

import 'core/di/injection.dart';
import 'features/login/presentation/stores/check_credential_store.dart';
import 'routes/app_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init(); //DI
  await _initHive(di.sl<HiveInterface>());
  runApp(MyApp());
}

Future<void> _initHive(HiveInterface hive) async {
  final directory = await path_provider.getApplicationSupportDirectory();
  hive.init(directory.path);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Movie Star',
        debugShowCheckedModeBanner: false,
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(
          initialRoutes: [
            GuardRoute(
                checkCredentialStore: sl<CheckCredentialStore>(),
                credentialGuard: sl<CredentialGuard>())
          ],
        ));
  }
}
