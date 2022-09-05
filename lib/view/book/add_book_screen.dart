// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:download_files_example/models/book.dart';
// import 'package:flutter/material.dart';

// class AddBookScreen extends StatefulWidget {
//   const AddBookScreen({Key? key}) : super(key: key);

//   @override
//   _AddBookScreenState createState() => _AddBookScreenState();
// }

// class _AddBookScreenState extends State<AddBookScreen> {
//   final collection = FirebaseFirestore.instance.collection("books");
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Book"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: isLoading
//               ? null
//               : () async {
//                   setState(() {
//                     isLoading = true;
//                   });
//                   try {
//                     Book book = Book(
//                       name: "سابغات",
//                       url: "https://www.kotobati.com/book/download/5efd3e40-cd2c-43a4-9324-c4cd5ad506e3",
//                       extensionFile: ".pdf",
//                       author: "أحمد يوسف السيد",
//                       imageUrl:
//                           "https://www.noor-book.com/publice/covers_cache_webp/5/6/c/0/973ba5c8e66c0da2d34ff2007c5c8cf9.jpg.webp",
//                       pageNumber: 239,
//                     );
//                     var ref = await collection.add(book.toMap());
//                     await ref.update({"id": ref.id});
//                     print("Done upload");
//                   } catch (error) {
//                     print(error.toString());
//                   }
//                   setState(() {
//                     isLoading = false;
//                   });
//                 },
//           child: Text("Add"),
//         ),
//       ),
//     );
//   }
// }
