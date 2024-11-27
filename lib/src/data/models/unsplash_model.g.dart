// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsplash_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnsplashModel _$UnsplashModelFromJson(Map<String, dynamic> json) =>
    UnsplashModel(
      altDescription: json['alt_description'] as String?,
      urls: json['urls'] == null
          ? null
          : Urls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnsplashModelToJson(UnsplashModel instance) =>
    <String, dynamic>{
      'alt_description': instance.altDescription,
      'urls': instance.urls,
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) => Urls(
      raw: json['raw'] as String?,
      full: json['full'] as String?,
      regular: json['regular'] as String?,
      small: json['small'] as String?,
      thumb: json['thumb'] as String?,
      smallS3: json['small_s3'] as String?,
    );

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
      'small_s3': instance.smallS3,
    };
