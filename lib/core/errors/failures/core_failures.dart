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
