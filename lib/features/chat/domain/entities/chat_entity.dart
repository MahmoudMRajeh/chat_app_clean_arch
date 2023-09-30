import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  String? lastMsg;
  Timestamp? lastMsgTime;
  String? recipientUID;
  String? senderUID;
  String? senderName;
  String? recipientName;
  String? profileUrl;

 ChatEntity(
      {this.lastMsg,
      this.lastMsgTime,
      this.recipientUID,
      this.senderUID,
      this.senderName,
      this.recipientName,
      this.profileUrl});

  @override
  List<Object?> get props => [
        lastMsg,
        lastMsgTime,
        senderUID,
        senderName,
        recipientUID,
        recipientName,
        profileUrl
      ];
}
