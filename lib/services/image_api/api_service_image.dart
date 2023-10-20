import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiServiceImage {
  static Future<String> createImage({required String message}) async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          'Authorization': 'Bearer ///////////////////////////',
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "prompt": message,
            "n": 1,
            "size": "256x256",
          },
        ),
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

      if (jsonResponse["data"].length > 0) {
        return jsonResponse["data"][0]["url"];
      }

      throw Exception("A URL não foi encontrada na resposta da API.");
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
