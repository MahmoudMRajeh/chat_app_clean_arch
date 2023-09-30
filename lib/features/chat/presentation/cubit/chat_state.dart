part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}
class GetAllUsersLoading extends ChatState{}
class GetAllUsersSuccess extends ChatState{}
class GetAllUsersFailure extends ChatState{
  final String errMsg;

 const GetAllUsersFailure(this.errMsg);
}
class GetAllMessegesSuccess extends ChatState{
  final List<MessegeEntity>messeges;
 const GetAllMessegesSuccess(this.messeges);
 @override
  List<Object> get props => [messeges];
}
class GetAllMessegesLoading extends ChatState{}
class SendMessegeFailure extends ChatState{}

class GetAllChatsLoading extends ChatState{}

class GetAllChatsSuccess extends ChatState{
  final List<ChatEntity>chats;
  const GetAllChatsSuccess(this.chats);
}
class UpdataChatSuccess extends ChatState{}
class UpdataChatFailure extends ChatState {}
