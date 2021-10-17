import '../failures.dart';

///This File has all failures could occours on any part of app
///
///All code is 00XX with this all errors tickets opened to this app will be more easy to track
class UnknowFailure extends Failure {
  @override
  String getCode() {
    return '0001';
  }

  @override
  String getMessage() {
    return 'Sorry, some very strange happened';
  }

  @override
  List<Object?> get props => [getCode()];
}

class UnauthorizedFailure extends Failure {
  @override
  String getCode() {
    return '0002';
  }

  @override
  String getMessage() {
    return 'You don\'t have authorization';
  }

  @override
  List<Object?> get props => [getCode()];
}

class NotFoundFailure extends Failure {
  @override
  String getCode() {
    return '0003';
  }

  @override
  String getMessage() {
    return 'Was not possible to find server';
  }

  @override
  List<Object?> get props => [getCode()];
}

class ResponseTimeOutFailure extends Failure {
  @override
  String getCode() {
    return '0004';
  }

  @override
  String getMessage() {
    return 'Could not receive response in time';
  }

  @override
  List<Object?> get props => [getCode()];
}

class ConnectTimeoutFailure extends Failure {
  @override
  String getCode() {
    return '0005';
  }

  @override
  String getMessage() {
    throw 'could not connect to server in time';
  }

  @override
  List<Object?> get props => [getCode()];
}
