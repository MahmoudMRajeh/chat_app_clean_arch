import 'package:chat/features/chat/domain/entities/messege_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessegeModel extends MessegeEntity {
  MessegeModel({
    String? recipientId,
    String? senderId,
    String? senderName,
    Timestamp? time,
    String? content,
    String? receiverName,
  }) : super(
          recipientId: recipientId,
          senderId: senderId,
          senderName: senderName,
          time: time,
          content: content,
          receiverName: receiverName,
        );
       factory MessegeModel.fromSnapshot(DocumentSnapshot snapshot) {
    return MessegeModel(
      recipientId: snapshot.get('recipientId'),
      senderId: snapshot.get('senderId'),
      senderName: snapshot.get('senderName'),
      time: snapshot.get('time'),
      content: snapshot.get('content'),
      receiverName: snapshot.get('receiverName'),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "recipientId": recipientId,
      "senderId": senderId,
      "senderName": senderName,
      "time": time,
      "content": content,
      "receiverName": receiverName,
    };
  } 
}
