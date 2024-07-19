import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_app/models/quote.dart';
import 'package:flutter_firebase_app/utils/utils.dart';

class RealtimeDatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  final String collectionName = 'post';

 // Create a new quote with timestamp in ID
  Future<void> createQuote(String title) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final id = timestamp;
      final quote = Quote(id: id, title: title);
      await _db.child(collectionName).child(id).set(quote.toMap());
    } catch (e) {
      Utils().toastMessage("Error: $e");
    }
  }

  // Read all quotes
  Stream<List<Quote>> getQuotes() {
    return _db.child(collectionName).orderByKey().onValue.map((event) {
      final List<Quote> quotes = [];
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        data.forEach((key, value) {
          quotes.add(Quote.fromMap(key, Map<String, dynamic>.from(value)));
        });
      }
    // Sort quotes in descending order of ID (timestamp)
      quotes.sort((a, b) => b.id.compareTo(a.id));
      return quotes;
    });
  }

  // Delete a quote
  Future<void> deleteQuote(String id) async {
    try {
      await _db.child(collectionName).child(id).remove();
       Utils().toastMessage("Quote deleted");
    } catch (e) {
       Utils().toastMessage("Error: $e");
    }
  }


   // Update a quote
  Future<void> updateQuote(String id, String newTitle) async {
    try {
      await _db.child(collectionName).child(id).update({'title': newTitle});
         Utils().toastMessage("Quote updated");
    } catch (e) {
         Utils().toastMessage("Error: $e");
    }
  }


}
