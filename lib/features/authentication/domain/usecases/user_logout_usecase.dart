import 'package:chat/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class UserLogoutUseCase {
  final AuthRepository authRepository;
  UserLogoutUseCase(this.authRepository);
  Future<Either<Failure, bool>> call() => authRepository.userLogout();
}
