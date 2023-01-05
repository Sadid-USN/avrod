// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextsModel _$TextsModelFromJson(Map<String, dynamic> json) => TextsModel(
      arabic: json['arabic'] as String?,
      id: json['id'] as String?,
      text: json['text'] as String?,
      translation: json['translation'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$TextsModelToJson(TextsModel instance) =>
    <String, dynamic>{
      'arabic': instance.arabic,
      'id': instance.id,
      'text': instance.text,
      'translation': instance.translation,
      'url': instance.url,
    };
