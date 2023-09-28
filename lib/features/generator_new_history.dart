import 'package:flutter/material.dart';

class GeneratorHistoryPage extends StatefulWidget {
  const GeneratorHistoryPage({super.key});

  @override
  State<GeneratorHistoryPage> createState() => _GeneratorHistoryPageState();
}

class _GeneratorHistoryPageState extends State<GeneratorHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie Sua História'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          child: SingleChildScrollView(
            child: Column(),
          ),
        ),
      ),
    );
  }
}
