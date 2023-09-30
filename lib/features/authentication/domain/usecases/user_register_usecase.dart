import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class UserRegisterUseCase {
  final AuthRepository authRepository;
  UserRegisterUseCase(this.authRepository);
  Future<Either<Failure, UserEntity>> call(
          {required String email,
          required String password,
          required String name}) =>
      authRepository.userRegister(email: email, password: password, name: name);
}
