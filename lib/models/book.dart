import 'package:avrod/models/chapter_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book.g.dart';

@JsonSerializable()
class Book {
  List<ChaptersModel>? chapters;
  String? image;
  String? name;

  Book({this.chapters, this.image, this.name});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
