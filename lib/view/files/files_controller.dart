import 'dart:async';
import 'dart:io';

import 'package:download_files_example/contracts/disposable.dart';
import 'package:download_files_example/helpers/storage_path.dart';

class FilesController implements Disposable {
  static final instance = FilesController._();
  late List<String> _filesPath;

  FilesController._() {
    _filesPath = [];
    getAllFiles().then((value) {
      _filesPath = value;
      _filesPathController.add(value);
    }).catchError((error) {
      _filesPathController.addError(error);
    });

    _addNewPathController.stream.listen(_addPath);
    _deletePathController.stream.listen(_deletePath);
  }

  StreamController<List<String>> _filesPathController = StreamController<List<String>>();

  Stream<List<String>> get filesPathStream => _filesPathController.stream;

  StreamSink<List<String>> get filesPathSink => _filesPathController.sink;

  StreamController<String> _addNewPathController = StreamController<String>();

  StreamSink<String> get addNewPath => _addNewPathController.sink;

  StreamController<String> _deletePathController = StreamController<String>();

  StreamSink<String> get deletePath => _deletePathController.sink;

  @override
  void dispose() {
    _filesPathController.close();
    _addNewPathController.close();
    _deletePathController.close();
  }

  void _addPath(String path) {
    _filesPath.add(path);
    filesPathSink.add(_filesPath);
  }

  Future<void> _deletePath(String path) async {
    _filesPath.remove(path);
    await File(path).delete();
    filesPathSink.add(_filesPath);
  }

  Future<List<String>> getAllFiles() async {
    List<String> filesPath = [];
    var path = await StoragePath.getPdfPath;
    await Directory(path).list().forEach(
      (element) {
        filesPath.add(element.path);
      },
    );
    return filesPath;
  }
}
