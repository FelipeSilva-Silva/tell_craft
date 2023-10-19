import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tell_craft/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json["msg"],
        chatIndex: json["chatIndex"],
      );

  Map<String, dynamic> toMap() {
    User? user = FirebaseAuth.instance.currentUser;
    return {'msg': msg, 'chatIndex': chatIndex, 'email': user!.email};
  }
}
