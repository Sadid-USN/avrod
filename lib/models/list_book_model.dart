import 'package:avrod/models/book.dart';
import 'package:json_annotation/json_annotation.dart';
part 'list_book_model.g.dart';

@JsonSerializable()
class ListBookModel {
  List<Book>? book;

  ListBookModel({this.book});

  factory ListBookModel.fromJson(Map<String, dynamic> json) =>
      _$ListBookModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListBookModelToJson(this);
}
