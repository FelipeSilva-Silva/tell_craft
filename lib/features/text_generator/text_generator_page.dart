import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Importe a biblioteca de visualização de PDF
import 'package:share/share.dart';
import 'package:tell_craft/components/pdf_viewer.dart';

class TextGenerator extends StatefulWidget {
  final String text;
  final String title;
  const TextGenerator({Key? key, required this.text, required this.title})
      : super(key: key);

  @override
  State<TextGenerator> createState() => _TextGeneratorState();
}

class _TextGeneratorState extends State<TextGenerator> {
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.text;
  }

  Future<Uint8List> createPDF(String text) async {
    final pdf = pdfWidgets.Document();

    pdf.addPage(pdfWidgets.Page(
      build: (pdfWidgets.Context context) {
        return pdfWidgets.Center(
          child: pdfWidgets.Text(text),
        );
      },
    ));

    return Uint8List.fromList(await pdf.save());
  }

  void addImageToPDF(String imagePath) {
    // Implemente a função para adicionar imagens ao PDF, se necessário
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
            Text(
              widget.title,
              style: const TextStyle(
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
                        controller: textEditingController,
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
                      final pdfBytes =
                          await createPDF(textEditingController.text);
                      final directory =
                          await getApplicationDocumentsDirectory();
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
                        'Gerar PDF',
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
