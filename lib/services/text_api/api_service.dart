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
          'Authorization': 'Bearer /////////////////////////////',
          "Content-Type":
              "application/json; charset=ISO-8859-1", // Especifica a codificação aqui
        },
        body: utf8.encode(jsonEncode(
          // Certifique-se de que a mensagem está codificada como UTF-8
          {
            "model": "text-davinci-003",
            "prompt": message,
            "max_tokens": 200, // limite?
          },
        )),
      );

      if (response.statusCode != 200) {
        throw HttpException(
            'Erro na solicitação. Código de status: ${response.statusCode}');
      }

      String responseBody = utf8.decode(response.bodyBytes,
          allowMalformed: true); // Decodifica a resposta com UTF-8

      Map jsonResponse = jsonDecode(responseBody);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
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
