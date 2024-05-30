import 'package:cook_book_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  ServerController serverController;
  BuildContext context;

  LoginPage({super.key, required this.serverController, required this.context});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userName = "";
  String userPassword = "";

  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 50), //Pone un padding vertical
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 77, 208, 225),
              Color.fromARGB(255, 0, 131, 143)
            ])),
            child: Image.asset(
              "assets/images/logo.png",
              color: Colors.white,
              height: 200,
            ),
          ),
          Transform.translate(
            offset: Offset(0, -60),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 260, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Usuario",
                              floatingLabelStyle: TextStyle(color: Colors.cyan),
                              hintStyle: TextStyle(color: Colors.cyan),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.cyan))),
                          cursorColor: Colors.cyan[300],
                          onSaved: (value) {
                            userName = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Contraseña",
                              floatingLabelStyle: TextStyle(color: Colors.cyan),
                              hintStyle: TextStyle(color: Colors.cyan),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.cyan))),
                          cursorColor: Colors.cyan[300],
                          obscureText: true,
                          onSaved: (value) {
                            userPassword = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Este campo es obligatorio";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            _login(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Iniciar Sesión",
                                style: TextStyle(color: Colors.white),
                              ),
                              if (_loading)
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                            ],
                          ),
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(_errorMessage,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("¿No estás registrado?"),
                            TextButton(
                              onPressed: () {
                                _showRegister(context);
                              },
                              child: Text("Registrarse"),
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  void _login(BuildContext context) async {
    if (!_loading) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        setState(() {
          _loading = true;
          _errorMessage = "";
        });
        User? user =
            await widget.serverController.login(userName, userPassword);
        if (user != null) {
          Navigator.of(context).pushReplacementNamed("/home", arguments: user);
        } else {
          setState(() {
            _loading = false;
            _errorMessage = "Usuario o contraseña incorrecta";
          });
        }
      }
    }
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }

  @override
  void initState() {
    super.initState();
    widget.serverController.init(widget.context);
  }
}
