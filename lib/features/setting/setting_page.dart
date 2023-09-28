import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final email = TextEditingController();
    final senha = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: name,
              enabled: false,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text('name'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ))),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: email,
              enabled: false,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  label: Text('Email'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ))),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.amber[600])),
                  onPressed: () => _showMyDialog(context),
                  child: const Text('Alterar senha'),
                ),
                const SizedBox(width: 25),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red[700])),
                  onPressed: () {},
                  child: const Text('Sair'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aterar Senha'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha é obrigatório'),
                  ]),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: UnderlineInputBorder(),
                    labelText: 'Nova Senha',
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha é obrigatório'),
                  ]),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: UnderlineInputBorder(),
                    labelText: 'Confirma Nova Senha',
                  ),
                ),
                const SizedBox(height: 15),
                const Text('Confirme com sua senha atual'),
                const SizedBox(height: 15),
                TextFormField(
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha é obrigatório'),
                  ]),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: UnderlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Alterar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
