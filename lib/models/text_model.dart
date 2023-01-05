import 'package:json_annotation/json_annotation.dart';
part 'text_model.g.dart';

@JsonSerializable()
class TextsModel {
  String? arabic;
  String? id;
  String? text;
  String? translation;
  String? url;

  TextsModel({
    this.arabic,
    this.id,
    this.text,
    this.translation,
    this.url,
  });

  factory TextsModel.fromJson(Map<String, dynamic> json) =>
      _$TextsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TextsModelToJson(this);
}
