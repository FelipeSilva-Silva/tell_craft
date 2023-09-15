import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> sendMessage({required String message}) async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/completions"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer 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',
        },
        body: jsonEncode(
          {
            "model": "text-davinci-003",
            "prompt": message,
            "max_tokens": 100,
          },
        ),
      );

      if (response.statusCode == 200) {
        // Verifique o tipo de conteúdo da resposta
        if (response.headers['content-type'] ==
            'application/json; charset=utf-8') {
          // A resposta é JSON válida
          Map jsonResponse = jsonDecode(response.body);

          if (jsonResponse['error'] != null) {
            throw HttpException(jsonResponse['error']["message"]);
          }

          if (jsonResponse["choices"].length > 0) {
            log("jsonResponse[choices] text ${jsonResponse["choices"][0]["text"]}");
          }
        } else {
          // A resposta não é JSON, talvez seja uma mensagem de erro em HTML
          throw HttpException("Erro na resposta da API: ${response.body}");
        }
      } else {
        // Trate outros códigos de status HTTP, se necessário
        throw HttpException("Erro de status HTTP: ${response.statusCode}");
      }
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
