import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class GeneratorHistoryPage extends StatefulWidget {
  const GeneratorHistoryPage({super.key});

  @override
  State<GeneratorHistoryPage> createState() => _GeneratorHistoryPageState();
}

class _GeneratorHistoryPageState extends State<GeneratorHistoryPage> {
  final _quantityCharacters = TextEditingController();
  final _namescharacters = TextEditingController();
  final _theme = TextEditingController();
  final _local = TextEditingController();

  @override
  void dispose() {
    _quantityCharacters.dispose();
    _namescharacters.dispose();
    _theme.dispose();
    _local.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Crie Sua História'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //quantidade de personagens
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      validator: Validatorless.required('Campo obrigatório'),
                      controller: _quantityCharacters,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text('Quantos personagens tem sua história?')),
                    ),
                  ),
                  //nomes dos personagens
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      validator: Validatorless.required('Campo obrigatório'),
                      controller: _namescharacters,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          label: Text(
                              'Nomes dos personagens separados por virgula')),
                    ),
                  ),
                  //tema
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      validator: Validatorless.required('Campo obrigatório'),
                      controller: _theme,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          label: Text('Qual o tema? ex: Fantasia, distopia')),
                    ),
                  ),
                  //local
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      validator: Validatorless.required('Campo obrigatório'),
                      controller: _local,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          label: Text('Nome do local? ex: Reino do repolho')),
                    ),
                  ),
                  //botao
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber[600])),
                        child: const Text(
                          'Criar História',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}