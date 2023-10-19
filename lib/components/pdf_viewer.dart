import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Importe a biblioteca de visualização de PDF
import 'package:share/share.dart';

class PdfViewerPage extends StatelessWidget {
  final File pdfFile;

  PdfViewerPage({required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar PDF'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Compartilhe o arquivo PDF
              sharePDF(pdfFile);
            },
          ),
        ],
      ),
      body:
          SfPdfViewer.file(pdfFile), // Use o visualizador de PDF do Syncfusion
    );
  }

  Future<void> sharePDF(File pdfFile) async {
    final bytes = await pdfFile.readAsBytes();
    final buffer = Uint8List.fromList(bytes);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/shared.pdf');
    await tempFile.writeAsBytes(buffer);
    await tempFile.copy(tempFile.path);
    await Share.shareFiles([tempFile.path]);
  }
}
