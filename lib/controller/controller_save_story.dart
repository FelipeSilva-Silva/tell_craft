import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tell_craft/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ControllerSaveStory {
  saveList(List<ChatModel> items, String title, String id) async {
    try {
      List<Map<String, dynamic>> listData =
          items.map((item) => item.toMap()).toList();

      await FirebaseFirestore.instance
          .collection('story')
          .doc(id)
          .set({id: listData});
    } catch (e) {
      print('Erro ao salvar a lista: $e');
    }
  }
}
