// To parse this JSON data, do
//
//     final unsplashModel = unsplashModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'unsplash_model.g.dart';

List<UnsplashModel> unsplashModelFromJson(String str) => List<UnsplashModel>.from(json.decode(str).map((x) => UnsplashModel.fromJson(x)));

String unsplashModelToJson(List<UnsplashModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class UnsplashModel {
    @JsonKey(name: "alt_description")
    final String? altDescription;
    @JsonKey(name: "urls")
    final Urls? urls;

    UnsplashModel({
        this.altDescription,
        this.urls,
    });

    UnsplashModel copyWith({
        String? altDescription,
        Urls? urls,
    }) => 
        UnsplashModel(
            altDescription: altDescription ?? this.altDescription,
            urls: urls ?? this.urls,
        );

    factory UnsplashModel.fromJson(Map<String, dynamic> json) => _$UnsplashModelFromJson(json);

    Map<String, dynamic> toJson() => _$UnsplashModelToJson(this);
}

@JsonSerializable()
class Urls {
    @JsonKey(name: "raw")
    final String? raw;
    @JsonKey(name: "full")
    final String? full;
    @JsonKey(name: "regular")
    final String? regular;
    @JsonKey(name: "small")
    final String? small;
    @JsonKey(name: "thumb")
    final String? thumb;
    @JsonKey(name: "small_s3")
    final String? smallS3;

    Urls({
        this.raw,
        this.full,
        this.regular,
        this.small,
        this.thumb,
        this.smallS3,
    });

    Urls copyWith({
        String? raw,
        String? full,
        String? regular,
        String? small,
        String? thumb,
        String? smallS3,
    }) => 
        Urls(
            raw: raw ?? this.raw,
            full: full ?? this.full,
            regular: regular ?? this.regular,
            small: small ?? this.small,
            thumb: thumb ?? this.thumb,
            smallS3: smallS3 ?? this.smallS3,
        );

    factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

    Map<String, dynamic> toJson() => _$UrlsToJson(this);
}
