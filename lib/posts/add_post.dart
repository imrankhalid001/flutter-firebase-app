import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_app/firebase_services/realtime_database_service.dart';
import 'package:flutter_firebase_app/ui/upload_image.dart';
import 'package:flutter_firebase_app/utils/utils.dart';
import 'package:flutter_firebase_app/widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final postController = TextEditingController();
  bool loading = false;
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          centerTitle: true,
          title: Text("Add Post"),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
         
          children: [
        
            SizedBox(height: 30,),
        
            TextFormField(
              maxLines: 5,
              controller: postController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add post',
                
              ),
            ),
             
            SizedBox(height: 30,),
            
            RoundButton(
              title: 'post',
              loading: loading,
             onTap: () async {

             setState(() {
                  loading = true;
                });

               final title = postController.text.toString();
                if (title.isNotEmpty) {
                   try {
                    await _databaseService.createQuote(title);
                    Utils().toastMessage('Post added');
                    postController.clear();
                    Navigator.pop(context);
                  } catch (e) {
                    Utils().toastMessage('Error: $e');
                  }
                   setState(() {
                    loading = false;
                  }); 
                }
                else
                {
                 Utils().toastMessage('please enter something');
                  setState(() {
                  loading = false;

                });
                }
            }),

               SizedBox(height: 30,),

            RoundButton(
              title: 'upload image', 
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const UploadImageScreen()));

            }
            )
          ],
        ),
      ),
    );
  }
}