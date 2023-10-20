// ignore: depend_on_referenced_packages
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

  static List<ChatModel> chatModelsFromList(List<Map<String, dynamic>> list) {
    List<ChatModel> x = list.map((map) {
      return ChatModel(
        msg: map['msg'] as String,
        chatIndex: map['chatIndex'] as int,
      );
    }).toList();

    return x;
  }
}
