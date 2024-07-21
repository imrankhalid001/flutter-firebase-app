import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/firebase_services/realtime_database_service.dart';
import 'package:flutter_firebase_app/models/quote.dart';
import 'package:flutter_firebase_app/posts/add_post.dart';
import 'package:flutter_firebase_app/ui/auth/login_screen.dart';
import 'package:flutter_firebase_app/ui/image_view_screen.dart';
import 'package:flutter_firebase_app/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {


  final auth = FirebaseAuth.instance;
  final RealtimeDatabaseService _databaseService = RealtimeDatabaseService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';



   @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }






 void _showEditDialog(Quote quote) {
    final TextEditingController editController = TextEditingController(text: quote.title);

    showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          title: Text('Edit Quote'),
          content: TextFormField(
            controller: editController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Edit title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = editController.text.trim();
                if (newTitle.isNotEmpty) {
                  _databaseService.updateQuote(quote.id, newTitle).then((_) {
                    Navigator.of(context).pop();
                  });
                } else {
                  Utils().toastMessage('Title cannot be empty');
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('post screen'),
        actions: [
          IconButton(onPressed: (){


            auth.signOut().then((value) {
              Navigator.push(context,  MaterialPageRoute(builder: (context)=> const LoginScreen()));
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            },);



          }, icon: const Icon(Icons.logout_outlined)),
          const SizedBox(width: 10,),
        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostScreen()));

      },

      child: Icon(Icons.add),
      
      
      ),  

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search by title',
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Quote>>(
        stream: _databaseService.getQuotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final quotes = snapshot.data!;
          if (quotes == null || quotes.isEmpty) {
            return Center(child: Text('No data found!',  style: TextStyle(fontSize: 16),));
          }

           // Filter quotes based on the search query
                final filteredQuotes = quotes.where((quote) {
                  return quote.title.toLowerCase().contains(_searchQuery.toLowerCase());
                }).toList();

                if (filteredQuotes.isEmpty) {
                  return Center(child: Text('No Results!'));
                }

          return ListView.builder(
                  itemCount: filteredQuotes.length,
                  itemBuilder: (context, index) {
                    final quote = filteredQuotes[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: GestureDetector(
                          onTap: () {
                            if (Uri.tryParse(quote.title)?.isAbsolute ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageViewScreen(imageUrl: quote.title),
                                ),
                              );
                            }
                          },
                          child: Text(
                            quote.title,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Uri.tryParse(quote.title)?.isAbsolute ?? false ? Colors.blue : Colors.black),
                          ),
                        ),
                        subtitle: Text(quote.id),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _showEditDialog(quote);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _databaseService.deleteQuote(quote.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
      
      
  }
  }
