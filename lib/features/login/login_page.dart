import 'package:flutter/material.dart';
import 'package:tell_craft/features/home_page.dart';
import 'package:tell_craft/features/login/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  late String _status = "";

  Future<void> _onClickEmailLogin() async {
    print("_onClickEmailLogin");

    String email = _email.text;
    String pass = _password.text;

    try {
      await _fbAuth.signInWithEmailAndPassword(email: email, password: pass);
      // Autenticação bem-sucedida, redirecione para a próxima tela (Home) se necessário
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } catch (e) {
      setState(() {
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found' || e.code == 'wrong-password') {
            _status = 'Credenciais inválidas, verifique seu email e senha.';
          } else {
            _status = 'Erro no login: ${e.message}';
          }
        } else {
          _status = 'Erro inesperado: $e';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logoTitle.png', scale: 0.5),
                const SizedBox(
                  height: 100,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _email,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Email está vazio';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              label: Text('Email'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _password,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Senha está vazia';
                            }
                            return null;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              label: Text('Senha'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ))),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterPage()));
                    },
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.only(right: 20, left: 20)),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: const Text('Cadastre-se'),
                  ),
                ),
                Center(
                  child: Text(
                    _status, // Exibe a mensagem de erro aqui
                    style: const TextStyle(
                      color: Colors.red, // Cor vermelha para mensagens de erro
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        //tirar para deixar o login prestando
                        if (_formKey.currentState!.validate()) {
                          _onClickEmailLogin();
                        }

                        //Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //builder: (context) => const Home(),
                        // ));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amber[600])),
                      child: const Text(
                        'Entrar',
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
    );
  }
}
