import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:tell_craft/services/text_api/api_service.dart';

void main() {
  test('Teste da API de texto', () async {
    // Mock response data
    final mockResponse = {
      "choices": [
        {"text": "Resposta 1"},
        {"text": "Resposta 2"},
        {"text": "Resposta 3"}
      ]
    };

    // Create a mock client
    final client = MockClient((request) async {
      // Return a mock response with status code 200
      return Response(jsonEncode(mockResponse), 200);
    });

    // Replace the default HttpClient with the mock client
    ApiService.httpClient = client;

    // Call the sendMessage function
    final response = await ApiService.sendMessage(message: "Pergunta");

    // Verify that the response is parsed correctly
    expect(response.length, 3);
    expect(response[0].msg, "Resposta 1");
    expect(response[1].msg, "Resposta 2");
    expect(response[2].msg, "Resposta 3");
  });
}
