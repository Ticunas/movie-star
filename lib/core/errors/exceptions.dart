///Used to throw known exceptions
abstract class Exception {}

///Special Case to unknow error
class UnknowException extends Exception {}

class HiveSaveException extends Exception {}

class NoCredentialException extends Exception {}

///Status code 401
class UnauthorizedException extends Exception {}

///Status code 404
class NotFoundException extends Exception {}

class ResponseTimeOutException extends Exception {}

class ConnectTimeOutException extends Exception {}
