import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class GetCacheUserUseCase {
  final AuthRepository authRepository;
  GetCacheUserUseCase(this.authRepository);
  Future<Either<Failure, String?>> call() => authRepository.getCacheUser();
}
