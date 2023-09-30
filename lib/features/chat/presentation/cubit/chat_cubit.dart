import 'dart:io';

import 'package:chat/features/authentication/domain/entities/user_entity.dart';
import 'package:chat/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat/features/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/domain/entities/messege_entity.dart';
import 'package:chat/features/chat/domain/usecases/get_all_chats_usecase.dart';
import 'package:chat/features/chat/domain/usecases/get_all_users_usecase.dart';
import 'package:chat/features/chat/domain/usecases/get_messeges_usecase.dart';
import 'package:chat/features/chat/domain/usecases/send_messege_use_case.dart';
import 'package:chat/features/chat/domain/usecases/updata_chat_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
      {required this.sendMessegesUsecase,
      required this.updataChatUsecase,
      required this.getAllChatsUsecase,
      required this.getMessegesUsecase,
      required this.getAllUsersUseCase})
      : super(ChatInitial());
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetMessegesUsecase getMessegesUsecase;
  final SendMessegesUsecase sendMessegesUsecase;
  final GetAllChatsUsecase getAllChatsUsecase;
  final UpdataChatUsecase updataChatUsecase;
  List<UserEntity> users = [];
  static ChatCubit get(context) => BlocProvider.of(context);
  UserEntity?user;
  getAllUsers({required String myUID,}) async {
    emit(GetAllUsersLoading());
    final response = await getAllUsersUseCase.call(myUID: myUID);
    response.fold((l) => emit(GetAllUsersFailure(l.errMsg)), (r) {
      for(var x in r){
        if(x.id!=myUID){
          users.add(x);
        }else{
          user=x;
        }
      }
      emit(GetAllUsersSuccess());
    });
  }
  getUserProfile({required String uid}){
    for(var x in users){
      if(x.id==uid){
        return x;
      }
    }
    return null;
  }
List<MessegeEntity> chatMesseges=[];
  getMesseges({required String firstUserId, required String secondUserId}) {
    emit(GetAllMessegesLoading());
    final streamResopnse = getMessegesUsecase.call(
        secondUserId: secondUserId, firstUserId: firstUserId);
    streamResopnse.listen((messeges) {
      chatMesseges=messeges;
      emit(
        GetAllMessegesSuccess(messeges),
      );
    });
  }
  updataChat({required String myUID,required String recipientUID,required Map<String,dynamic>document})async{
    try {
      await updataChatUsecase.call(myUID: myUID, recipientUID: recipientUID, document: document);
      //print("updated");
    } catch (_) {
      emit(UpdataChatFailure());
    }
  }

  sendMessege({required MessegeEntity messege,required String profileUrl,required String myUID,required String recipientUID})async{
    try {
      await sendMessegesUsecase.call(messege: messege);
      Map<String ,dynamic>document = {
    "senderName": messege.senderName,
    "recipientName": messege.receiverName,
    "recipientUID": messege.recipientId,
    "senderUID": messege.senderId,
    "profileUrl": profileUrl,
    "time": messege.time,
    'recentTextMessage':messege.content,
      };
      updataChat(myUID: myUID, recipientUID: recipientUID, document: document);
    } on SocketException catch(_){
      emit(SendMessegeFailure());
    }catch(_){
      emit(SendMessegeFailure());
    }
  }
  List<ChatEntity> allChat=[];
  getAllChats({required String uid}){
  emit(GetAllChatsLoading());
    final streamResopnse = getAllChatsUsecase.call(uid: uid);
    streamResopnse.listen((chats) {
      allChat=chats;
      emit(
        GetAllChatsSuccess(chats)
      );
    });
  }
}
