import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class ChangePrfoilePhotoRepository {
  Future<Either<Failure,File>>changeProfilePhoto();
  Future<Either<Failure,void>>uploadProfilePhoto({required File image,required String id});
}