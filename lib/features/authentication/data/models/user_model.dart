import 'package:chat/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.email, required super.name, required super.id,super.profileImage, required super.bio,});
  factory UserModel.fromJson({required Map<String,dynamic>json}){
    return UserModel(email: json["email"], name: json["name"], id: json["id"],profileImage: json["profileImage"], bio: json['bio']);
  }
  Map<String,dynamic>toJson(){
    return {
      "email":email,
      "name":name,
      "id":id,
      "bio":bio,
      "profileImage":profileImage
    };
  }
}