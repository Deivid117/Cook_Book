// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cook_book_app/src/components/image_picker_widget.dart';
import 'package:cook_book_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class RegisterPage extends StatefulWidget {
  ServerController serverController;
  BuildContext context;
  User? userToEdit;

  RegisterPage(
      {super.key,
      required this.serverController,
      required this.context,
      this.userToEdit});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffKey = GlobalKey<ScaffoldState>();

  String userName = "";
  String userPassword = "";
  Genrer genrer = Genrer.MALE;

  File? imageFile;
  bool showPassword = false;
  bool isEditingUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffKey,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [

              ImagePickerWidget(
                  imageFile: imageFile,
                  onImageSelected: (File file) {
                    setState(() {
                      imageFile = file;
                    });
                  }),

              SizedBox(
                height: kToolbarHeight + 25,
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Center(
                child: Transform.translate(
                  offset: const Offset(0, -40),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 260, bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: ListView(
                        children: [
                          TextFormField(
                            initialValue: userName,
                            decoration: const InputDecoration(
                                labelText: "Usuario",
                                floatingLabelStyle:
                                    TextStyle(color: Colors.cyan),
                                hintStyle: TextStyle(color: Colors.cyan),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.cyan))),
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
                            initialValue: userPassword,
                            decoration: InputDecoration(
                                labelText: "Contraseña",
                                floatingLabelStyle:
                                    const TextStyle(color: Colors.cyan),
                                hintStyle: const TextStyle(color: Colors.cyan),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan)),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                    icon: Icon(showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                            cursorColor: Colors.cyan[300],
                            obscureText: !showPassword,
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
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Género",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RadioListTile(
                                      value: Genrer.MALE,
                                      groupValue: genrer,
                                      onChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            genrer = value;
                                          });
                                        }
                                      },
                                      title: const Text(
                                        "Masculino",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    RadioListTile(
                                      value: Genrer.FEMALE,
                                      groupValue: genrer,
                                      onChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            genrer = value;
                                          });
                                        }
                                      },
                                      title: const Text("Femenino",
                                          style: TextStyle(fontSize: 12)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _doProcess(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (isEditingUser) ? "Actualizar" : "Registrar",
                                  style: const TextStyle(color: Colors.white),
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
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _doProcess(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      if (imageFile == null) {
        showSnackBar(context, "Selecciona una imagen", Colors.orange);
        return;
      }
      User user = User(
          nickname: userName,
          password: userPassword,
          genrer: genrer,
          photo: imageFile!);
      var state;
      if (isEditingUser) {
        user.id = ServerController().loggedUser?.id;
        state = await widget.serverController.updateUser(user);
      } else {
        state = await widget.serverController.addUser(user);
      }

      final action = isEditingUser ? "actualizar" : "guardar";
      final action2 = isEditingUser ? "actualizado" : "registrado";

      if (state == false) {
        showSnackBar(context, "No se pudo $action", Colors.orange);
      } else {
        showSnackBar(
            context,
            "Usuario $action2",
            Colors.orange);
      }
    }
  }

  void showSnackBar(BuildContext context, String title, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor,
    ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.userToEdit != null) {
      userName = widget.userToEdit!.nickname;
      userPassword = widget.userToEdit!.password;
      imageFile = widget.userToEdit!.photo;
      genrer = widget.userToEdit!.genrer;
      isEditingUser = true;
    }
  }
}
