import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:download_files_example/models/book.dart';
import 'package:download_files_example/view/home/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class HomeScreenWithPagination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      query: FirebaseFirestore.instance.collection("books"),
      pageSize: 10,
      loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
      errorBuilder: (context, obj, stack) => Center(child: Text("Error")),
      itemBuilder: (context, QueryDocumentSnapshot query) {
        Book book = Book.fromMap(query.data() as Map<String, dynamic>);
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: BookItem(book: book),
        );
      },
    );
  }
}
