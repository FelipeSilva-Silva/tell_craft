import 'package:flutter/material.dart';
import 'package:tell_craft/features/home_page.dart';
import 'package:tell_craft/features/login/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
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
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Home(),
                        ));
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
