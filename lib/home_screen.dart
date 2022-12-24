import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    openGallery() async {
      XFile? picture =
          (await ImagePicker().pickImage(source: ImageSource.gallery));
      setState(() {
        imageFile = picture as File;
      });
    }

    openCamera() async {
      XFile? picture =
          (await ImagePicker().pickImage(source: ImageSource.camera));
      setState(() {
        imageFile = File(picture!.path);
        GallerySaver.saveImage(imageFile!.path, toDcim: true);
      });
    }

    Widget imageView() {
      if (imageFile == null) {
        return const Text('No image Selected');
      } else {
        return Image.file(
          imageFile!,
          width: 300,
          height: 400,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                openCamera();
              },
              icon: const Icon(Icons.camera_alt_outlined),
              iconSize: 50,
            ),
            IconButton(
                onPressed: () {
                  openGallery();
                },
                icon: const Icon(Icons.folder_open_outlined),
                iconSize: 50
                ),
            SizedBox(
                height: 350, width: 450, child: Center(child: imageView(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
