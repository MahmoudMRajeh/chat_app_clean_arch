import 'package:chat/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UpdataProfileDataRepo{
  Future<Either<Failure,void>>updataProfileData({String?name,String?bio,required String id});
}