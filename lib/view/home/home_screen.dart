import 'package:download_files_example/helpers/book_api.dart';
import 'package:download_files_example/models/book.dart';
import 'package:download_files_example/view/home/book_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: BookApi.getBooks(),
            builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Center(child: Text("Error"));
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 40);
                },
                itemBuilder: (BuildContext context, int index) {
                  return BookItem(book: snapshot.data![index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
