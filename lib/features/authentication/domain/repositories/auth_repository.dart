import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
abstract class AuthRepository {
  Future<Either<Failure,UserEntity>> userLogin({required String email, required String password});
  Future<Either<Failure,UserEntity>> userRegister(
      {required String email, required String name, required String password});
  Future<Either<Failure,String?>>getCacheUser();
  Future<Either<Failure,bool>>userLogout();
}
