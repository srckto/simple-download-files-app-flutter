import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:download_files_example/models/book.dart';

class BookApi {
  BookApi._();

  static Future<List<Book>> getBooks() async {
    List<Book> books = [];

    var ref = await FirebaseFirestore.instance.collection("books").get();
    ref.docs.forEach((element) {
      books.add(Book.fromMap(element.data()));
    });

    return books;
  }
}
