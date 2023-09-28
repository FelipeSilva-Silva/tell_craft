import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tell_craft/models/chat_model.dart';

class ApiService {
  static Future<List<ChatModel>> sendMessage({required String message}) async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/completions"),
        headers: {
          'Authorization':
              'Bearer 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',
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "model": "text-davinci-003",
            "prompt": message,
            "max_tokens": 100, // limite?
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        //log("jsonResponse[choices] text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
