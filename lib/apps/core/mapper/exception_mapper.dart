import '../exceptions/app_exceptions.dart';
import '../failure/failure.dart';

extension ExceptionMapper on AppException {
  Failure toFailure() {
    switch (this) {
      case NetworkException():
        return NetworkFailure(message);

      case UnauthorizedException():
        return UnauthorizedFailure(message);

      case ServerException():
        return ServerFailure(message);

      case CancelledByUserException():
        return const CancelledByUserFailure();

      case CacheException():
        return CacheFailure(message);
      case BiometricException():
        return BiometricFailure(message);

      default:
        return UnexpectedFailure(message);
    }
  }
}
