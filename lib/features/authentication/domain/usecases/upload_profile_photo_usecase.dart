import 'dart:io';

import 'package:chat/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/change_profile_photo_repo.dart';

class UploadPrfoilePhotoUseCase {
  final ChangePrfoilePhotoRepository changePrfoilePhotoRepository;

  UploadPrfoilePhotoUseCase({required this.changePrfoilePhotoRepository});
  Future<Either<Failure, void>> call({required File image,required String id}) =>
      changePrfoilePhotoRepository.uploadProfilePhoto(image:image,id:id);
}
