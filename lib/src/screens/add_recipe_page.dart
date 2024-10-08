// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cook_book_app/src/components/image_picker_widget.dart';
import 'package:cook_book_app/src/components/ingredient_widget.dart';
import 'package:cook_book_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class AddRecipePage extends StatefulWidget {

  ServerController serverController;
  final Recipe? recipe;
  
  AddRecipePage({super.key, required this.serverController, this.recipe});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();

}

class _AddRecipePageState extends State<AddRecipePage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  String name = "", description = "";
  List<String> ingredientsList = [], stepsList = [];
  File? photoFile;
  
  final nIngredientControler = TextEditingController();
  final nPasoController = TextEditingController();
  
  File? imageFile;

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Stack(
          children: <Widget>[

            ImagePickerWidget(
              imageFile: imageFile,
              onImageSelected: (File file) {
                setState(() {
                  imageFile = file;
                });
              },
            ),

            SizedBox(
              height: kToolbarHeight + 25,
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.white),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      _save(context);
                    },
                  )
                ],
              ),
            ),
            Center(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 260, bottom: 20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: ListView(children: <Widget>[
                    TextFormField(
                      initialValue: name,
                      decoration:
                          const InputDecoration(labelText: "Nombre de receta"),
                      onSaved: (value) {
                        name = value!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "LLene este campo";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: description,
                      decoration: const InputDecoration(labelText: "Descripción"),
                      onSaved: (value) {
                        description = value!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "LLene este campo";
                        }
                        return null;
                      },
                      maxLines: 6,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    
                    ListTile(
                      title: const Text("Ingredientes"),
                      trailing: FloatingActionButton(
                        heroTag: "uno",
                        child: const Icon(Icons.add),
                        onPressed: () {
                          _ingredientDialog(context);
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    
                    getIngredientsList(),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: const Text("Pasos"),
                      trailing: FloatingActionButton(
                        heroTag: "dos",
                        child: const Icon(Icons.add),
                        onPressed: () {
                          _stepDialog(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    getStepsList()
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getStepsList() {
    if (stepsList.isEmpty) {
      return const Text(
        "Listado vacío",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      );
    } else {
      return Column(
        children: List.generate(stepsList.length, (index) {
          final ingredient = stepsList[index];
          return IngredientWidget(
            index: index,
            ingredientName: ingredient,
            onIngredientDeleteCallback: _onStepDelete,
            onIngredientEditCallback: _onStepEdit,
          );
        }),
      );
    }
  }

  Widget getIngredientsList() {
    if (ingredientsList.isEmpty) {
      return const Text(
        "Listado vacío",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      );
    } else {
      return Column(
        children: List.generate(ingredientsList.length, (index) {
          final ingredient = ingredientsList[index];
          return IngredientWidget(
            index: index,
            ingredientName: ingredient,
            onIngredientDeleteCallback: _onIngredientDelete,
            onIngredientEditCallback: _onIngredientEdit,
          );
        }),
      );
    }
  }

  void _ingredientDialog(BuildContext context, {String? ingredient, int? index}) {
    final textController = TextEditingController(text: ingredient);
    final editing = ingredient != null;
    onSave() {
      final text = textController.text;
      if (text.isEmpty) {
        _showSnackBar("El nombre está vacío", backColor: Colors.orange);
      } else {
        setState(() {
          if (editing) {
            ingredientsList[index!] = text;
          } else {
            ingredientsList.add(text);
          }
          Navigator.pop(context);
        });
      }
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                editing ? "Editando ingrediente" : "Agregando ingrediente"),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: "Ingrediente"),
              onEditingComplete: onSave,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                onPressed: onSave,
                child: Text(editing ? "Actualizar" : "Guardar"),
              ),
            ],
          );
        });
  }

  void _stepDialog(BuildContext context, {String? step, int? index}) {
    final textController = TextEditingController(text: step);
    final editing = step != null;
    onSave() {
      final text = textController.text;
      if (text.isEmpty) {
        _showSnackBar("El paso está vacío", backColor: Colors.orange);
      } else {
        setState(() {
          if (editing) {
            stepsList[index!] = text;
          } else {
            stepsList.add(text);
          }
          Navigator.pop(context);
        });
      }
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(editing ? "Editando paso" : "Agregando paso"),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: "Paso",
              ),
              textInputAction: TextInputAction.newline,
              maxLines: 6,
              //onEditingComplete: onSave,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                onPressed: onSave,
                child: Text(editing ? "Actualizar" : "Guardar"),
              ),
            ],
          );
        });
  }

  void _showSnackBar(String message, {Color backColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backColor,
      ),
    );
  }

  void _onIngredientEdit(int index) {
    final ingredient = ingredientsList[index];
    _ingredientDialog(context, ingredient: ingredient, index: index);
  }

  void _onIngredientDelete(int index) {
    questionDialog(context, "¿Seguro desea eliminar el ingrediente?", () {
      setState(() {
        ingredientsList.removeAt(index);
      });
    });
  }

  void _onStepEdit(int index) {
    final step = stepsList[index];
    _stepDialog(context, step: step, index: index);
  }

  void _onStepDelete(int index) {
    questionDialog(context, "¿Seguro desea eliminar el paso?", () {
      setState(() {
        stepsList.removeAt(index);
      });
    });
  }

  void questionDialog(BuildContext context, String message, VoidCallback onOk) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Si"),
                onPressed: () {
                  Navigator.pop(context);
                  onOk();
                },
              ),
            ],
          );
        });
  }

  void _save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      if (imageFile == null) {
        _showSnackBar("La imágen está vacía");
        return;
      }
      if (ingredientsList.isEmpty) {
        _showSnackBar("No tiene ingredientes");
        return;
      }
      if (stepsList.isEmpty) {
        _showSnackBar("No tiene pasos");
        return;
      }

      final recipe = Recipe(
          name: name,
          description: description,
          ingredients: ingredientsList,
          steps: stepsList,
          photo: imageFile!,
          user: widget.serverController.loggedUser!,
          date: DateTime.now());

      if(isEditing) {
        recipe.id = widget.recipe!.id;
      }    

      bool saved = false;

      if(isEditing) {
        saved = await widget.serverController.updateRecipe(recipe);  
      } else {
        final Recipe? recipe2 = await widget.serverController.addRecipe(recipe);
        saved = recipe2 != null;
      }

      if (saved) {
        Navigator.pop(context, recipe);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text("Receta guardada exitosamente"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      } else {
        _showSnackBar("No se pudo realizar");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEditing = widget.recipe != null;
    if(isEditing) {
      name = widget.recipe!.name;
      description = widget.recipe!.description;
      ingredientsList = widget.recipe!.ingredients;
      stepsList = widget.recipe!.steps;
      imageFile = widget.recipe!.photo;
    }
  }
}
