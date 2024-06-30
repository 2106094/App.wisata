import 'package:firebase_storage/firebase_storage.dart'; // Tambahkan import ini
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'user.dart';
import 'package:path/path.dart' as path;

class AddStatusPage extends StatefulWidget {
  final User user;

  const AddStatusPage({Key? key, required this.user}) : super(key: key);

  @override
  _AddStatusPageState createState() => _AddStatusPageState();
}

class _AddStatusPageState extends State<AddStatusPage> {
  final TextEditingController _descriptionController = TextEditingController();
  List<File> _images = [];
  bool _isUploading = false;

  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<List<String>> _uploadImages() async {
    List<String> imageUrls = [];
    for (var image in _images) {
      String fileName = path.basename(image.path);
      Reference storageRef = FirebaseStorage.instance.ref().child('status_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  void _submitStatus() async {
    if (_images.isNotEmpty && _descriptionController.text.isNotEmpty) {
      setState(() {
        _isUploading = true;
      });
      List<String> imageUrls = await _uploadImages();
      final newStatus = {
        'description': _descriptionController.text,
        'images': imageUrls,
        'user': widget.user,
      };
      Navigator.pop(context, newStatus);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap tambahkan deskripsi dan gambar.'),
        ),
      );
    }
    setState(() {
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Status'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: _pickImages,
                icon: Icon(Icons.camera_alt),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Tambahkan Caption...',
                    ),
                    maxLines: null,
                  ),
                  const SizedBox(height: 16),
                  _images.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.file(_images[index]),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isUploading ? null : _submitStatus,
                    child: _isUploading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text('Post'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
