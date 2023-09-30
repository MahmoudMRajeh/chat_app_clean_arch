abstract class Failure{
  final String errMsg;

  Failure(this.errMsg);
}
class AuthException extends Failure{
  AuthException(super.errMsg);
}
class CacheException extends Failure{
  CacheException(super.errMsg);
}
class PickImageException extends Failure{
  PickImageException(super.errMsg);
}

class FirestoreException extends Failure{
  FirestoreException(super.errMsg);
}

class FirestorageException extends Failure{
  FirestorageException(super.errMsg);
}