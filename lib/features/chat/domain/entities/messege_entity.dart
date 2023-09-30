import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessegeEntity extends Equatable {
  final String? recipientId;
  final String? senderId;
  final String? senderName;
  final Timestamp? time;
  final String? content;
  final String? receiverName;

  MessegeEntity(
      {this.recipientId,
      this.senderId,
      this.senderName,
      this.time,
      this.content,
      this.receiverName,
      });

  @override
  List<Object?> get props => [
    receiverName,recipientId,senderId,senderName,time,content
  ];
}
