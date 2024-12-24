import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DottedImagePicker extends StatefulWidget {
  final Function(File?) onImagePicked;

  DottedImagePicker({required this.onImagePicked, Key? key}) : super(key: key);

  @override
  _DottedImagePickerState createState() => _DottedImagePickerState();
}

class _DottedImagePickerState extends State<DottedImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImagePicked(_image); // Pass the image back to the parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      borderType: BorderType.RRect,
      radius: Radius.circular(8),
      dashPattern: [10, 5],
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            image: _image != null
                ? DecorationImage(
              image: FileImage(_image!), // Correctly use FileImage here
              fit: BoxFit.cover,
            )
                : null,

          ),
          child: _image == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload, color: Colors.grey, size: 50),
              Text("Tap to select image"),
            ],
          )
              : null,
        ),
      ),
    );
  }
}
