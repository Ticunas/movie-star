import 'package:equatable/equatable.dart';

///Used to create more friendly messages to user and better tracking with issue tickets by code
///
///[code] each failure should have a code to better tracking
///
///[message] friendly message to user
abstract class Failure extends Equatable {
  final List properties;
  const Failure([this.properties = const <dynamic>[]]);
  String getCode();
  String getMessage();
}
