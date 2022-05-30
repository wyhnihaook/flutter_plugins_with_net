// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicData _$MusicDataFromJson(Map<String, dynamic> json) => MusicData(
      name: json['name'] as String?,
      url: json['url'] as String?,
      picurl: json['picurl'] as String?,
      artistsname: json['artistsname'] as String?,
    );

Map<String, dynamic> _$MusicDataToJson(MusicData instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'picurl': instance.picurl,
      'artistsname': instance.artistsname,
    };
