class UserEntity {
  final String name, email, id;
  final String? profileImage,bio;
  UserEntity(
     {
    required this.profileImage,
     required this.bio,

    required this.email,
    required this.name,
    required this.id,
  });
}
