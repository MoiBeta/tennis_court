import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog extends StatelessWidget {

  final ImagePicker _picker = ImagePicker();

  ImagePickerDialog({super.key});

  Future<String?> options(int option) async {
    XFile? file = await _picker.pickImage(
      source: option == 1
          ? ImageSource.gallery
          : ImageSource.camera,
      maxHeight: 640, maxWidth: 480,
    );
    return file?.path;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                String? path = await options(2);
                Navigator.of(context).pop(
                  path,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                        BorderSide(width: 1, color: Colors.grey))),
                child: const Row(
                  children: [
                    Expanded(child: Text('Tomar foto')),
                    Icon(Icons.camera_alt_outlined)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                String? path = await options(1);
                Navigator.of(context).pop(
                  path,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                        BorderSide(width: 1, color: Colors.grey))),
                child: const Row(
                  children: [
                    Expanded(child: Text('Seleccionar desde galeria')),
                    Icon(Icons.image, color: Colors.green)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                        BorderSide(width: 1, color: Colors.grey))),
                child: const Row(
                  children: [
                    Expanded(child: Text('Cancelar')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
