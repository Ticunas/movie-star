import 'package:movie_star/core/errors/failures.dart';

///This File has all failures could occours only ib Login feature
///
///All code is 02XX with this all errors tickets opened to this app will be more easy to track
class NoCredentialFailure extends Failure {
  @override
  String getCode() {
    return '0201';
  }

  @override
  String getMessage() {
    return 'No Credential Registered';
  }

  @override
  List<Object?> get props => [getCode()];
}
