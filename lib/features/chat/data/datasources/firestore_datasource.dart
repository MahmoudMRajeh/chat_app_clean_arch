import 'package:chat/features/authentication/data/models/user_model.dart';
import 'package:chat/features/chat/data/models/chat_model.dart';
import 'package:chat/features/chat/data/models/messege_model.dart';
import 'package:chat/features/chat/domain/entities/messege_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
abstract class FireStoreDataSource {
  Future<List<UserModel>> getAllUsers({required String myUID});
  Stream<List<MessegeModel>> getMesseges(
      {required String secondUserId, required String firstUserId});
  Future<void> setMessegeInMyCollection({required MessegeEntity messege});
  Future<void> setMessegeInUserCollection({required MessegeEntity messege});
  Stream<List<ChatModel>> getAllChats({required String uid});
 Future<void> updateChat(
      {required String myUID,
      required String recipientUID,
      required Map<String,dynamic>document});
}

class FireStoreDataSourceImpl extends FireStoreDataSource {
  final FirebaseFirestore firestore;

  FireStoreDataSourceImpl({required this.firestore});
  @override
  Future<List<UserModel>> getAllUsers({required String myUID}) async {
    List<UserModel> users = [];
    final response = await firestore.collection("users").get();
    for (var x in response.docs) {
      if (x.data()["id"] != myUID) {
        users.add(UserModel.fromJson(json: x.data()));
      }
    }
    return users;
  }

  @override
  Future<void> updateChat(
      {required String myUID,
      required String recipientUID,
      required Map<String,dynamic>document}) async{
    var chatRef = firestore
        .collection("users")
        .doc(myUID)
        .collection("chats")
        .doc(recipientUID);
    await chatRef.set(document);

  }
  @override
  Stream<List<ChatModel>> getAllChats({required String uid}) {
    final chatRef = firestore.collection("users").doc(uid).collection("chats");
    return chatRef.orderBy("time",descending: true).snapshots().map((querySnap) => querySnap.docs
        .map(
          (queryDoc) => ChatModel.fromSnapshot(queryDoc),
        )
        .toList());
  }

  @override
  Stream<List<MessegeModel>> getMesseges(
      {required String secondUserId, required String firstUserId}) {
    final chatRef = firestore
        .collection("users")
        .doc(firstUserId)
        .collection("chats")
        .doc(secondUserId);
    final messegeRef = chatRef.collection("messeges");
    return messegeRef.orderBy("time").snapshots().map(
          (querySnap) => querySnap.docs
              .map((queryDoc) => MessegeModel.fromSnapshot(queryDoc))
              .toList(),
        );
  }

  @override
  Future<void> setMessegeInMyCollection(
      {required MessegeEntity messege}) async {
    final chatRef = firestore
        .collection("users")
        .doc(messege.senderId)
        .collection("chats")
        .doc(messege.recipientId)
        .collection("messeges");
    final newMsg = MessegeModel(
      content: messege.content,
      senderId: messege.senderId,
      senderName: messege.senderName,
      receiverName: messege.receiverName,
      recipientId: messege.recipientId,
      time: messege.time,
    ).toDocument();
    chatRef.doc().set(newMsg);
  }

  @override
  Future<void> setMessegeInUserCollection(
      {required MessegeEntity messege}) async {
    final chatRef = firestore
        .collection("users")
        .doc(messege.recipientId)
        .collection("chats")
        .doc(messege.senderId)
        .collection("messeges");
    final newMsg = MessegeModel(
      content: messege.content,
      senderId: messege.senderId,
      senderName: messege.senderName,
      receiverName: messege.receiverName,
      recipientId: messege.recipientId,
      time: messege.time,
    ).toDocument();
    chatRef.doc().set(newMsg);
  }
}
