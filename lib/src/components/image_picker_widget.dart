import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

typedef OnImageSelected = Function(File imageFile);

class ImagePickerWidget extends StatelessWidget {
  final File? imageFile;
  final OnImageSelected onImageSelected;

  const ImagePickerWidget(
      {super.key, required this.imageFile, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 77, 208, 225),
            Color.fromARGB(255, 0, 131, 143)
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          image: imageFile != null
              ? DecorationImage(image: _buildImageProvider(imageFile!.path, imageFile!), fit: BoxFit.cover)
              : null),
      child: IconButton(
        onPressed: () {
          _showPickerOptions(context);
        },
        icon: const Icon(Icons.camera_alt),
        iconSize: 90,
        color: Colors.white,
      ),
    );
  }

  void _showPickerOptions(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(
        children: [
          ListTile(
            title: const Text("Cámara"),
            leading: const Icon(Icons.camera),
            onTap: () { 
              Navigator.pop(context);
              _showPickImage(context, ImageSource.camera); 
              },
          ),
          ListTile(
            title: const Text("Galería"),
            leading: const Icon(Icons.browse_gallery),
            onTap: () { 
              Navigator.pop(context);
              _showPickImage(context, ImageSource.gallery); 
              },
          ),
        ],
      );
    });
  }
  
  void _showPickImage(BuildContext context, source) async {
    var image = await ImagePicker().pickImage(source: source);
      if(image != null) {
        onImageSelected(File(image.path));
      }
   }

   ImageProvider _buildImageProvider(String path, File photo) {
    if (File(path).existsSync()) {
      // Si se toma una foto o de la galería entonces tomará ese archivo
      return FileImage(photo);
    } else {
      // Si aún no se toma una foto se muestra la foto original del backend fake.
      return AssetImage(path);
    }
  }
}
