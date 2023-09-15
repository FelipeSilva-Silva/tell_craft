import 'package:flutter/material.dart';
import 'package:tell_craft/features/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  late String _status = "";

  Future<void> _onClickEmailCreate() async {
    print("_onClickEmailCreate");

    String email = _email.text;
    String pass = _password.text;

    _fbAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((firebaseUser) {
      setState(() {
        _status = "Sucesso! email: ${firebaseUser.user!.email}";
      });
    }).catchError((erro) {
      setState(() {
        _status = "Erro no create: " + erro.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Container(
        color: Colors.black,
        child: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logoTitle.png', scale: 0.5),
              const SizedBox(
                height: 80,
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
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: 'Email',
                        ),
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
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: 'Senha',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _confirmPassword,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Confirmar senha está vazio';
                          }
                          if (_password.text != _confirmPassword.text) {
                            return 'Confirmar senha está diferente de senha';
                          }
                          return null;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_reset),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: 'Confirmar senha',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // if para verificar se é valido e se confirmar e senha são iguais
                      if (_formKey.currentState!.validate()) {
                        _onClickEmailCreate();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber[600])),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
