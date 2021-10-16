///Used to throw known exceptions
abstract class Exception {}

///Special Case to unknow error
class UnknowException extends Exception {}

class HiveSaveException extends Exception {}

class NoCredentialException extends Exception {}
