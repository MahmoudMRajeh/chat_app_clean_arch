import 'package:chat/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/updata_profile_data_repo.dart';

class UpdataProfileDataUsecase {
  final UpdataProfileDataRepo updataProfileDataRepo;

  UpdataProfileDataUsecase({required this.updataProfileDataRepo});
  Future<Either<Failure, void>> call(
          {required String id, String? bio, String? name}) =>
      updataProfileDataRepo.updataProfileData(id: id, name: name, bio: bio);
}
