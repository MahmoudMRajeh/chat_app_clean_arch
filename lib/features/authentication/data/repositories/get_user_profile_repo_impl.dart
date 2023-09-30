import 'package:chat/features/authentication/data/datasources/remote_firebase_datasource.dart';
import 'package:chat/features/authentication/data/models/user_model.dart';
import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/authentication/domain/repositories/get_user_profile_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserProfileRepositoryImpl extends GetUserProfileRepository{
  final FireBaseDataSource fireBaseDataSource;

  GetUserProfileRepositoryImpl({required this.fireBaseDataSource});
  @override
  Future<Either<Failure, UserEntity>> getUserProfile({required String id}) async{
    UserModel?user=await fireBaseDataSource.getUser(id: id);
    if(user==null){
      return Left(AuthException("Failed to get profile data"));
    }else{
      return Right(user);
    }
  }

}