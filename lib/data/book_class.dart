class Book {
  String? name;
  String? image;
  List<Chapter>? chapter;

  Book({this.name, this.image, this.chapter});

  Book.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    if (json['chapters'] != null) {
      chapter = [];
      json['chapters'].forEach((v) {
        chapter!.add(Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    if (chapter != null) {
      data['chapters'] = chapter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapter {
  String? listimage;
  String? name;
  List<Texts>? texts;

  Chapter({this.listimage, this.name, this.texts});

  Chapter.fromJson(Map<String, dynamic> json) {
    listimage = json['listimage'];
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
    data['listimage'] = listimage;
    data['name'] = name;
    if (texts != null) {
      data['texts'] = texts!.map((v) => v.toJson()).toList();
    }
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
