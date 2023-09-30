import 'dart:io';

import 'package:chat/core/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_model.dart';

abstract class FireBaseDataSource {
  Future<UserCredential> userLogin(
      {required String email, required String password});
  Future<UserModel?> userRegister(
      {required String email, required String name, required String password});
  Future<bool> userLogOut();
  Future<UserModel?> getUser({required String? id});
  Future<TaskSnapshot?> uploadImage({required File image});
  Future<bool> updataImage({required String imageUrl, required String id});
  Future<bool> updataProfileData(
      {String? name, String? bio, required String id});
}
class FireBaseAuthDataSourceImpl extends FireBaseDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  FireBaseAuthDataSourceImpl(
      {required this.firebaseStorage,
      required this.auth,
      required this.firestore});
  @override
  Future<bool> userLogOut() async {
    await auth.signOut();
    return auth.currentUser == null;
  }

  @override
  Future<UserCredential> userLogin(
      {required String email, required String password}) async {
    return await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<UserModel?> userRegister(
      {required String email,
      required String name,
      required String password}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    UserModel user = UserModel(
        email: email,
        name: name,
        id: userCredential.user!.uid,
        profileImage: AppConstants.defaultProfileImage,
        bio: '');
    Map<String, dynamic> data = user.toJson();
    await firestore.collection("users").doc(userCredential.user!.uid).set(data);
    return user;
  }

  @override
  Future<UserModel?> getUser({required String? id}) async {
    if (id != null) {
      DocumentSnapshot<Map<String, dynamic>> responseData =
          await firestore.collection("users").doc(auth.currentUser!.uid).get();
      UserModel user = UserModel.fromJson(json: responseData.data()!);
      return user;
    }
    return null;
  }

  @override
  Future<TaskSnapshot?> uploadImage({required File image}) async {
    return await firebaseStorage
        .ref()
        .child("users/${Uri.file(image.path).pathSegments.last}")
        .putFile(image);
  }

  @override
  Future<bool> updataImage(
      {required String imageUrl, required String id}) async {
    await firestore
        .collection("users")
        .doc(id)
        .update({"profileImage": imageUrl});
    return true;
  }

  @override
  Future<bool> updataProfileData(
      {String? name, String? bio, required String id}) async {
      await firestore
          .collection("users")
          .doc(id)
          .update({"name": name, "bio": bio});
    return true;
  }
}
