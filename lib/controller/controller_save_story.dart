import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tell_craft/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ControllerSaveStory {
  saveList(List<ChatModel> items) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      List<Map<String, dynamic>> listData =
          items.map((item) => item.toMap()).toList();

      await FirebaseFirestore.instance
          .collection('story')
          .doc(user!.uid)
          .set({"story": listData});
    } catch (e) {
      print('Erro ao salvar a lista: $e');
    }
  }
}
