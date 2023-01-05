// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      chapters: (json['chapters'] as List<dynamic>?)
          ?.map((e) => ChaptersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'chapters': instance.chapters,
      'image': instance.image,
      'name': instance.name,
    };
