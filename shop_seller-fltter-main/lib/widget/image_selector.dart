import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  Function(File) imageData;
  ImageSelector({Key? key, required this.imageData}) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File? file;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _picker.pickImage(source: ImageSource.gallery).then((value) {
          widget.imageData(File(value!.path));
          setState(() {
            file = File(value.path);
          });
        });
      },
      child: file == null
          ? Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxRz_9nC6MmZSVU70VZfqR7yANMsR4z3rvJQ&usqp=CAU",
              width: 90,
              height: 90,
            )
          : Image.file(
              file!,
              width: 75,
              height: 75,
            ),
    );
  }
}
