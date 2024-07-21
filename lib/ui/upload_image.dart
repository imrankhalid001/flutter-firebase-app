import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/firebase_services/realtime_database_service.dart';
import 'package:flutter_firebase_app/utils/utils.dart';
import 'package:flutter_firebase_app/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  File? _image;
  final picker = ImagePicker();
    bool _isUploading = false;
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService();

   Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    if (_image == null) {
      Utils().toastMessage('No image selected');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    String fileName = basename(_image!.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');

    try {
      await firebaseStorageRef.putFile(_image!);
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      if(downloadURL.isNotEmpty)
      {
              try {
                    await _databaseService.createQuote(downloadURL);
                    Utils().toastMessage('Url added');
                  } catch (e) {
                    Utils().toastMessage('Error: $e');
                  }

      }

      Utils().toastMessage("Image uploaded successfully.");

  setState(() {
        _image = null;
        _isUploading = false;
      });

      Navigator.of(context).pop();

    } catch (e) {
      Utils().toastMessage("Error occurred while uploading: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: Text('Upload image'),
      ),

     body: Center(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!),
              SizedBox(height: 20),
              RoundButton(
                title: 'Pick Image',
                loading: false,
                onTap:(){
                    pickImage();
                }
            
               
              ),
          
              SizedBox(height: 20),
              
              RoundButton(
                title: 'Upload Image',
                loading: _isUploading,
                onTap: () => uploadImageToFirebase(context),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
    
  }
