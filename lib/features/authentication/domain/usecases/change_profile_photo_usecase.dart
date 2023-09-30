import 'dart:io';

import 'package:chat/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/change_profile_photo_repo.dart';

class ChangePrfoilePhotoUseCase {
  final ChangePrfoilePhotoRepository changePrfoilePhotoRepository;

  ChangePrfoilePhotoUseCase({required this.changePrfoilePhotoRepository,});
  Future<Either<Failure, File>> call() =>
      changePrfoilePhotoRepository.changeProfilePhoto();
}
