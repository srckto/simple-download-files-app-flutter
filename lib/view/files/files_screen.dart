import 'package:download_files_example/view/files/files_controller.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  final controller = FilesController.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: controller.filesPathStream,
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) return Center(child: Text("Error"));
        if (snapshot.data!.isEmpty) return Center(child: Text("You don't have files yet"));
        return ListView.separated(
          itemCount: snapshot.data!.length,
          separatorBuilder: (context, int) => SizedBox(height: 20),
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Accept Delete."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          controller.deletePath.add(snapshot.data![index]);
                          Navigator.pop(context);
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No"),
                      ),
                    ],
                  ),
                );
              },
              onTap: () {
                OpenFile.open(snapshot.data![index]);
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                child: Center(
                  child: Text(snapshot.data![index].split("/").last),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
