import 'dart:ffi';

import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/authentication/data/datasources/remote_firebase_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/updata_profile_data_repo.dart';

class UpdataProfileDataRepoImpl extends UpdataProfileDataRepo {
  final FireBaseDataSource fireBaseDataSource;

  UpdataProfileDataRepoImpl({required this.fireBaseDataSource});

  @override
  Future<Either<Failure, void>> updataProfileData(
      {String? name, String? bio, required String id}) async {
    if (await fireBaseDataSource.updataProfileData(
        id: id, name: name, bio: bio)) {
      // ignore: void_checks
      return const Right(Void);
    }
    return Left(FirestoreException("Failed to updata data"));
  }
}
