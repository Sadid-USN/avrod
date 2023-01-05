// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBookModel _$ListBookModelFromJson(Map<String, dynamic> json) =>
    ListBookModel(
      book: (json['book'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListBookModelToJson(ListBookModel instance) =>
    <String, dynamic>{
      'book': instance.book,
    };
