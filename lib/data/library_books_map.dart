class LibraryBooks {
  List<Books>? books;

  LibraryBooks({this.books});

  LibraryBooks.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = [];
      json['books'].forEach((v) {
        books!.add( Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String ?name;
  String ?url;

  Books({this.name, this.url});

  Books.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
