import 'dart:developer';

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tell_craft/components/pdf_viewer.dart';
import 'package:tell_craft/controller/controller_save_story.dart';
import 'package:tell_craft/models/chat_model.dart';
import 'package:tell_craft/services/text_api/api_service.dart';
import 'package:tell_craft/widgets/chat_widget.dart';
import 'package:tell_craft/widgets/text_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Importe a biblioteca de visualização de PDF
import 'package:share/share.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tell_craft/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String? textFromCreateButton;
  final String id;
  // Altere o tipo para String

  const ChatPage(
      {super.key,
      required this.title,
      this.textFromCreateButton,
      required this.id});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  final controllerSaveStory = ControllerSaveStory();

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
    textEditingController =
        TextEditingController(text: widget.textFromCreateButton);
    sendMessageFCT();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  Future<Uint8List> createPDF(List<ChatModel> chatList) async {
    final pdf = pdfWidgets.Document();

    for (var chat in chatList) {
      pdf.addPage(pdfWidgets.Page(
        build: (pdfWidgets.Context context) {
          return pdfWidgets.Center(
            child: pdfWidgets.Text(chat.msg),
          );
        },
      ));
    }

    return Uint8List.fromList(await pdf.save());
  }

  void addImageToPDF(String imagePath) {
    // Implemente a função para adicionar imagens ao PDF, se necessário
  }

  @override
  Widget build(BuildContext context) {
    controllerSaveStory.saveList(chatList, widget.title, widget.id);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_outline_sharp,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  final pdfBytes = await createPDF(chatList);
                  final directory = await getApplicationDocumentsDirectory();
                  final pdfPath = '${directory.path}/generated_text.pdf';
                  final pdfFile = File(pdfPath);
                  await pdfFile.writeAsBytes(pdfBytes);

                  // Navegue para a tela de visualização do PDF
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(pdfFile: pdfFile),
                    ),
                  );
                } catch (e) {
                  print("error $e");
                }
              },
              icon: const Icon(
                Icons.picture_as_pdf,
                size: 30,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(children: [
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatList[index].msg,
                      chatIndex: chatList[index].chatIndex,
                    );
                  }),
            ),
            if (_isTyping) ...[
              // coloca quantos widgets quiser
              const SpinKitThreeBounce(color: Colors.white, size: 18),
            ],
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
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT();
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "Como posso te ajudar?",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessageFCT();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  void scrollListToEnd() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT() async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Espere sua resposta para digitar outra pergunta",
            fontSize: 15,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Por favor, digite algo",
            fontSize: 15,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: msg, chatIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });
      chatList.addAll(await ApiService.sendMessage(
          // salvar esse lista no firebase?
          message: msg));
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: error.toString(),
            fontSize: 15,
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}
