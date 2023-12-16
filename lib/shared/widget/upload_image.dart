import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:path/path.dart' as path;

class UploadImage extends StatefulWidget {
  final Function(String? photoPath)? onTakePhoto;

  const UploadImage({Key? key, this.onTakePhoto}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _imageFile;

  Future<void> _capturePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    final pickedImage = File(pickedFile.path);
    final appDocumentPath = await getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedImage.path);
    final newPath = '${appDocumentPath.path}/$fileName';
    final result = await pickedImage.copy(newPath);

    widget.onTakePhoto?.call(result.path); // Use the callback
    setState(() {
      _imageFile = File(result.path);
    });
  }

  Widget _buildImagePreview() {
    return _imageFile != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(AppDesign.circularRadius),
            child: Image.file(
              _imageFile!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
        : const Placeholder(
            fallbackWidth: double.infinity,
            fallbackHeight: 200,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImagePreview(),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _capturePhoto,
          child: const Text('Take Photo'),
        ),
      ],
    );
  }
}
