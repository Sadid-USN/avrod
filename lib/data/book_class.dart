class Book {
  String? name;
  String? image;
  List<String>? chapters;

  Book({this.name, this.image, this.chapters});

  static Book fromJson(json) => Book(
    name: json['name'],
    image: json['image'],
    chapters: ['chapters']
  );
}

// class ListAvrod {
//   final List<Avrod>? avrod;

//   ListAvrod({this.avrod});
//   factory ListAvrod.fromJson(List<dynamic> parsedJson) {
//     List<Avrod> avrod = [];
//     avrod = parsedJson.map((e) => Avrod.fromJson(e)).toList();
//     return ListAvrod(avrod: avrod);
//   }
// }
