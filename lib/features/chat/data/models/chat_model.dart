
import 'package:chat/features/chat/domain/entities/chat_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends ChatEntity{
  ChatModel({
    String? senderName,
    String? recipientName,
    String? recipientUID,
    String? senderUID,
    String? profileUrl,
    String? lastMsg,
    Timestamp? time,
  }) : super(
      senderName:senderName,
      recipientName:recipientName,
      recipientUID:recipientUID,
      senderUID:senderUID,
      profileUrl:profileUrl,
      lastMsg:lastMsg,
      lastMsgTime:time,
  );
  
factory ChatModel.fromSnapshot(DocumentSnapshot snapshot) {
  return ChatModel(
    senderName: snapshot.get('senderName'),
    recipientName: snapshot.get('recipientName'),
    recipientUID: snapshot.get('recipientUID'),
    senderUID: snapshot.get('senderUID'),
    profileUrl: snapshot.get('profileUrl'),
    lastMsg: snapshot.get('recentTextMessage'),
    time: snapshot.get('time'),
  );
}
Map<String, dynamic> toDocument() {
  return {
    "senderName": senderName,
    "recipientName": recipientName,
    "recipientUID": recipientUID,
    "senderUID": senderUID,
    "profileUrl": profileUrl,
    "time": lastMsg,
    'recentTextMessage':lastMsg,
  };
}
}