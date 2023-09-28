import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.grey.shade800, // fazer um if para as cores como o index
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.person), // fazer um if para as fotinhas com o index
                SizedBox(
                  width: 8,
                ),
                Text("Aqui vai a msg") // msg com index
              ],
            ),
          ),
        )
      ],
    );
  }
}
