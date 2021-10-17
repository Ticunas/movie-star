import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/features/login/presentation/page/login_page.dart';
import 'package:movie_star/features/login/presentation/stores/check_credential_store.dart';
import 'package:movie_star/features/login/presentation/stores/save_credential_store.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'core/di/injection.dart';
import 'package:movie_star/core/di/injection.dart' as di;

import 'features/login/domain/entities/credential.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init(); //DI
  await _initHive(di.sl<HiveInterface>());
  runApp(const MyApp());
}

Future<void> _initHive(HiveInterface hive) async {
  final directory = await path_provider.getApplicationSupportDirectory();
  hive.init(directory.path);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
        saveCredentialStore: sl<SaveCredentialStore>(),
      ),
    );
  }
}
