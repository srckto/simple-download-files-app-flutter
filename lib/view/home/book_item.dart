import 'dart:io';

import 'package:dio/dio.dart';
import 'package:download_files_example/components/build_image.dart';
import 'package:download_files_example/components/custom_toast.dart';
import 'package:download_files_example/helpers/constants.dart';
import 'package:download_files_example/helpers/storage_path.dart';
import 'package:download_files_example/models/book.dart';
import 'package:download_files_example/view/files/files_controller.dart';
import 'package:flutter/material.dart';

class BookItem extends StatefulWidget {
  BookItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  double downloadSize = 0;
  double totalSize = 0;
  double percentage = 0;
  File? file;
  Dio dio = Dio();
  bool isDownloading = false;
  bool isDownloaded = false;

  CancelToken cancelToken = CancelToken();

  Future<void> cancelDownload() async {
    cancelToken.cancel();
  }

  Future<void> download() async {
    try {
      print("Starting downloading file ${widget.book.name}");
      if (cancelToken.isCancelled) {
        cancelToken = CancelToken();
      }

      var dir = await StoragePath.getPdfPath;
      var savePath = dir + widget.book.name! + widget.book.extensionFile!; // ".pdf"

      if (await File(savePath).exists()) {
        CustomToast.show(
          "This file already exists",
          Colors.red,
        );
        throw "";
      }

      setState(() {
        isDownloading = true;
        isDownloaded = false;
      });
      await dio.download(
        widget.book.url!,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: (int received, int totalBytes) {
          setState(() {
            downloadSize = received / MB;
            totalSize = totalBytes / MB;
            percentage = (downloadSize / totalSize) * 100;
            if (percentage == 100) {
              isDownloaded = true;
              file = File(savePath);
              FilesController.instance.addNewPath.add(savePath);
            }
          });
        },
      );
    } on DioError catch (error) {
      print("================ Dio Error ==================");
      print(error.toString());
    } catch (error) {
      print(error.toString());
    }
    setState(() {
      isDownloading = false;
      percentage = 0;
      downloadSize = 0;
      totalSize = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            BuildImage(url: widget.book.imageUrl!),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.book.name!),
                    Text("Author : " + widget.book.author!),
                    Text("Pages : " + widget.book.pageNumber!.toString()),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: isDownloading
                      ? () {
                          cancelDownload();
                        }
                      : () {
                          download();
                        },
                  icon: Icon(Icons.download),
                  color: isDownloading ? Colors.green : Colors.black,
                ),
                if (isDownloading && !isDownloaded)
                  Text(
                    percentage.toStringAsFixed(2),
                  ),
              ],
            ),
          ],
        ),
        if (isDownloading && !isDownloaded)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: LinearProgressIndicator(
              value: percentage / 100,
            ),
          ),
      ],
    );
  }
}
