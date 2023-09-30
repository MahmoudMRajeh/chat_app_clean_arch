import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class UserLoginUseCase {
  final AuthRepository authRepository;
  UserLoginUseCase(this.authRepository);
  Future<Either<Failure, UserEntity>> call(
          {required String email, required String password}) =>
      authRepository.userLogin(email: email, password: password);
}
