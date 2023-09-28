import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tell_craft/widgets/chat_widget.dart';

class ChatPage extends StatefulWidget {
  final String text;
  final String title;
  const ChatPage({super.key, required this.text, required this.title});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

final chatMsg = [
  {
    "msg": "hello how",
    "chatIndex": 0,
  },
  {
    "msg": "tudo benne",
    "chatIndex": 1,
  },
  {
    "msg": "hello how aaaaaa",
    "chatIndex": 0,
  },
  {
    "msg": "tudo benneeeeeee",
    "chatIndex": 1,
  },
  {
    "msg": "hello how are you",
    "chatIndex": 0,
  },
  {
    "msg":
        "Excepteur eiusmod quis proident exercitation fugiat aliqua incididunt elit enim. Proident ullamco qui ullamco labore laborum fugiat exercitation aliquip. Veniam fugiat excepteur fugiat minim ipsum do consequat commodo eu irure elit magna cupidatat magna. Id veniam qui incididunt elit amet. Occaecat nulla quis excepteur eu esse sit qui. Ipsum labore magna nisi excepteur culpa Lorem do Occaecat eiusmod officia sint cupidatat. Velit dolor minim in quis mollit mollit ipsum officia. Ad non ea cupidatat consequat est.",
    "chatIndex": 1,
  },
];

class _ChatPageState extends State<ChatPage> {
  final bool _isTyping = true;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          //title: Image.asset('assets/images/logoTitle.png'),
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {}, // pode colocar o titulo da historia aqui
              icon: const Icon(
                Icons.person_outline_sharp,
                size: 30,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                        msg: chatMsg[index]["msg"].toString(),
                        chatIndex:
                            int.parse(chatMsg[index]["chatIndex"].toString()),
                      );
                    }),
              ),
              if (_isTyping) ...[
                // coloca quantos widgets quiser
                const SpinKitThreeBounce(color: Colors.white, size: 18),
                const SizedBox(
                  height: 15,
                ),
                Material(
                  color: Colors.grey.shade800,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: textEditingController,
                            onSubmitted: (value) {
                              // todo send message
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: "Como posso te ajudar?",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]
            ],
          ),
        ));
  }
}
