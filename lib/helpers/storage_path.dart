import 'package:path_provider/path_provider.dart';

class StoragePath {
  StoragePath._();

  static Future<String> get getPdfPath async {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path.replaceAll("app_flutter", "") + "pdf_files/";
  }
}
