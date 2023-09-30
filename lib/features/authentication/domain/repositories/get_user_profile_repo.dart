import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class GetUserProfileRepository{
    Future<Either<Failure,UserEntity>>getUserProfile({required String id});
}