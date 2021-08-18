class Book {
  String? name;
  String? image;
  List<Chapters>? chapters;

  Book({this.name, this.image, this.chapters});

  Book.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    if (json['chapters'] != null) {
      chapters = [];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Chapters {
  String? name;
  List<Texts>? texts;

  Chapters({this.name, this.texts});

  Chapters.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['texts'] != null) {
      texts = [];
      json['texts'].forEach((v) {
        texts!.add(Texts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['texts'] = texts!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Texts {
  String? id;
  String? text;
  String? arabic;
  String? translation;

  Texts({this.id, this.text, this.arabic, this.translation});

  Texts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    arabic = json['arabic'];
    translation = json['translation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['arabic'] = arabic;
    data['translation'] = translation;
    return data;
  }
}
