import 'package:avrod/models/text_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chapter_model.g.dart';

@JsonSerializable()
class ChaptersModel {
  int? id;
  String? listimage;
  String? name;
  List<TextsModel>? texts;

  ChaptersModel({this.id, this.listimage, this.name, this.texts});

  factory ChaptersModel.fromJson(Map<String, dynamic> json) =>
      _$ChaptersModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChaptersModelToJson(this);
}
