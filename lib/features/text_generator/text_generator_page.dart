import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tell_craft/services/text_api/api_service.dart';

class TextGenerator extends StatefulWidget {
  final String text;
  const TextGenerator({super.key, required this.text});

  @override
  State<TextGenerator> createState() => _TextGeneratorState();
}

class _TextGeneratorState extends State<TextGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/logoTitle.png'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline_sharp,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Historia X',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.10,
                      height: MediaQuery.of(context).size.height * 0.72,
                      color: const Color(0xff24262e),
                      child: TextField(
                        controller: TextEditingController(text: widget.text),
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.justify,
                        maxLines: null,
                        decoration: const InputDecoration(
                          fillColor: Color(0xff24262e),
                          filled: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      log("Request has been sent");
                      await ApiService.sendMessage(
                          // trocar pelo controller
                          message: "faça uma reflexão sobre a vida");
                    } catch (e) {
                      print("error $e");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Gerar texto',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Refazer',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
