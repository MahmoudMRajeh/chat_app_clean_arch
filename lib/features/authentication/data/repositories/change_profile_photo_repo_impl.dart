import 'dart:ffi';
import 'dart:io';
import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/authentication/data/datasources/local_data_source.dart';
import 'package:chat/features/authentication/data/datasources/remote_firebase_datasource.dart';
import 'package:chat/features/authentication/domain/repositories/change_profile_photo_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChangePrfoilePhotoRepositoryImpl extends ChangePrfoilePhotoRepository {
  final LocalDataSource localDataSource;
  final FireBaseDataSource fireBaseDataSource;
  ChangePrfoilePhotoRepositoryImpl(
      {required this.localDataSource, required this.fireBaseDataSource});
  @override
  Future<Either<Failure, File>> changeProfilePhoto() async {
    File? image;
    final pickedImage = await localDataSource.pickImage();
    if (pickedImage != null) {
      image = File(pickedImage.path);
      return Right(image);
    }
    return Left(PickImageException("Failed to pick an image"));
  }
  @override
  Future<Either<Failure, void>> uploadProfilePhoto(
      {required File image, required String id}) async {
    TaskSnapshot? response = await fireBaseDataSource.uploadImage(image: image);
    if (response == null) {
      return Left(FirestorageException("Failed to upload profile photo"));
    }
    String imageUrl = await _handleTaskSnapshot(taskSnapshot: response);
    if (await fireBaseDataSource.updataImage(imageUrl: imageUrl, id: id)) {
      

      return const Right(Void);
    } else {
      return Left(FirestoreException("Failed to upddata profile photo"));
    }
  }

  Future<String> _handleTaskSnapshot(
      {required TaskSnapshot taskSnapshot}) async {
    return await taskSnapshot.ref.getDownloadURL();
  }
}
