// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChaptersModel _$ChaptersModelFromJson(Map<String, dynamic> json) =>
    ChaptersModel(
      id: json['id'] as int?,
      listimage: json['listimage'] as String?,
      name: json['name'] as String?,
      texts: (json['texts'] as List<dynamic>?)
          ?.map((e) => TextsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChaptersModelToJson(ChaptersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listimage': instance.listimage,
      'name': instance.name,
      'texts': instance.texts,
    };
