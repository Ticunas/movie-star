import '../failures.dart';

///This File has all failures could occours using Hive
///
///All code is 01XX with this all errors tickets opened to this app will be more easy to track
class HiveSaveFailure extends Failure {
  @override
  String getCode() {
    return '0102';
  }

  @override
  String getMessage() {
    return 'A error occours trying to save data';
  }

  @override
  List<Object?> get props => [getCode()];
}
