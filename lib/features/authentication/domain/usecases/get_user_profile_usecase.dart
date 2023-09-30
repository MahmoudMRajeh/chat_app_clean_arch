import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/get_user_profile_repo.dart';

class GetUserProfileUseCase {
  final GetUserProfileRepository getUserProfileRepository;

  GetUserProfileUseCase({required this.getUserProfileRepository});
  Future<Either<Failure, UserEntity>> call({required String id}) =>
      getUserProfileRepository.getUserProfile(id: id);
}
