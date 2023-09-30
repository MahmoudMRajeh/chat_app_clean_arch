import 'package:chat/features/authentication/data/models/user_model.dart';
import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/chat/data/datasources/firestore_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/get_all_users_repo.dart';

class GetAllUsersRepositoryImpl extends GetAllUsersRepository{
  final FireStoreDataSource fireStoreDataSource;

  GetAllUsersRepositoryImpl({required this.fireStoreDataSource});
  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers({required String myUID}) async{
    List<UserModel>users=await fireStoreDataSource.getAllUsers(myUID:myUID);
    if(users.isEmpty){
      return Left(FirestoreException("there's no users"));
    }
    return Right(users);
  }
}