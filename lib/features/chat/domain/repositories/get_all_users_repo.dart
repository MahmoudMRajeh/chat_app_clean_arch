import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../authentication/data/models/user_model.dart';

abstract class GetAllUsersRepository{
  Future<Either<Failure, List<UserModel>>> getAllUsers({required String myUID});
}