import 'dart:io';
import 'package:path/path.dart';

///Used to simulate json response from server
String fixture(String path) => File('$_testDirectory/$path').readAsStringSync();

final _testDirectory = join(
  Directory.current.path,
  Directory.current.path.endsWith('test') ? '' : 'test',
);
