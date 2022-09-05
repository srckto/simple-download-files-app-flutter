class Book {
  String? id;
  String? name;
  String? author;
  String? url;
  String? imageUrl;
  String? extensionFile;
  int? pageNumber;

  Book({
    this.id,
    this.author,
    this.name,
    this.extensionFile,
    this.imageUrl,
    this.pageNumber,
    this.url,
  });

  Book.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.author = map["author"];
    this.name = map["name"];
    this.extensionFile = map["extension_file"];
    this.imageUrl = map["image_url"];
    this.pageNumber = map["page_number"];
    this.url = map["url"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "author": this.author,
      "name": this.name,
      "extension_file": this.extensionFile,
      "image_url": this.imageUrl,
      "page_number": this.pageNumber,
      "url": this.url,
    };
  }
}
