import 'dart:developer';

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tell_craft/components/pdf_viewer.dart';
import 'package:tell_craft/controller/controller_save_story.dart';
import 'package:tell_craft/models/chat_model.dart';
import 'package:tell_craft/services/image_api/api_service_image.dart';
import 'package:tell_craft/services/text_api/api_service.dart';
import 'package:tell_craft/widgets/chat_widget.dart';
import 'package:tell_craft/widgets/text_widget.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  final String title;
  final String? textFromCreateButton;
  final String id;
  final List<ChatModel>? chat;
  // Altere o tipo para String

  const ChatPage(
      {super.key,
      required this.title,
      this.textFromCreateButton,
      required this.id,
      this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  final controllerSaveStory = ControllerSaveStory();
  var pdf = pdfWidgets.Document();
  bool addingImage = false; // variável de controle

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
    textEditingController =
        TextEditingController(text: widget.textFromCreateButton);
    pdf = pdfWidgets.Document(); // Crie o PDF no initState
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

  @override
  Widget build(BuildContext context) {
    if (widget.chat != null) {
      chatList = widget.chat!;
    }
    controllerSaveStory.saveList(chatList, widget.title, widget.id);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title),
          actions: [
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
                    ),
                    IconButton(
                      onPressed: () async {
                        final imageUrl = await generateImageFromText(
                            textEditingController
                                .text); // Espere a URL da imagem

                        addImageToPDF(imageUrl);
                        textEditingController.clear();
                      },
                      icon: const Icon(
                        Icons.add_photo_alternate,
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
      String msg = "";
      if (chatList.isNotEmpty) {
        msg = chatList.last.msg;
        msg = "$msg\n\n${textEditingController.text}";
      } else {
        msg = textEditingController.text;
      }

      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: msg, chatIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });
      chatList.addAll(await ApiService.sendMessage(message: msg));
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

  Future<String> generateImageFromText(String text) async {
    try {
      final imageUrl = await ApiServiceImage.createImage(
          message: textEditingController.text);
      print(imageUrl);

      return imageUrl;
    } catch (error) {
      log("Error while generating image: $error");
      throw error;
    }
  }

  Future<void> savePDF(pdfWidgets.Document pdf) async {
    final directory = await getApplicationDocumentsDirectory();
    final pdfPath = '${directory.path}/generated_text_with_image.pdf';
    final pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(Uint8List.fromList(await pdf.save()));

    // Navegue para a tela de visualização do PDF
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(pdfFile: pdfFile),
      ),
    );
  }

  Future<void> addImageToPDF(String imageUrl) async {
    if (imageUrl.isNotEmpty) {
      // Obtenha o diretório temporário
      final tempDir = await getTemporaryDirectory();

      // Abra uma conexão HTTP para baixar a imagem
      final imageResponse = await http.get(Uri.parse(imageUrl));

      if (imageResponse.statusCode == 200) {
        final imageFilePath = '${tempDir.path}/image.png';

        final imageFile = File(imageFilePath);
        await imageFile.writeAsBytes(imageResponse.bodyBytes);

        final image = pdfWidgets.MemoryImage(imageFile.readAsBytesSync());

        // Adicione a imagem ao PDF existente
        pdf.addPage(pdfWidgets.Page(
          build: (pdfWidgets.Context context) {
            return pdfWidgets.Center(
              child: pdfWidgets.Image(image),
            );
          },
        ));

        setState(() {});
      }
    }
  }
}
