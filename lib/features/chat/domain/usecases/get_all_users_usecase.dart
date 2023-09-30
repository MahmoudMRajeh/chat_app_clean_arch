import 'package:chat/features/chat/domain/repositories/get_all_users_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../authentication/domain/entities/user_entity.dart';

class GetAllUsersUseCase {
  final GetAllUsersRepository getAllUsersRepo;

  GetAllUsersUseCase({required this.getAllUsersRepo});
  Future<Either<Failure,List<UserEntity>>>call({required String myUID})=>getAllUsersRepo.getAllUsers(myUID:myUID);  
}