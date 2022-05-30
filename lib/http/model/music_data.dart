import 'package:json_annotation/json_annotation.dart';

///描述:音乐信息
///功能介绍:音乐信息，使用json_annotation动态生成代码
///创建者:翁益亨
///创建日期:2022/5/27 18:01

//下方书写完毕之后，运行命令行进行自动生成依赖
//命令行：flutter packages pub run build_runner build
//flutter packages pub run build_runner build --delete-conflicting-outputs

part 'music_data.g.dart';

@JsonSerializable()
class MusicData{

  String? name;
  String? url;
  String? picurl;
  String? artistsname;

  MusicData({this.name, this.url, this.picurl, this.artistsname});

  //下面两个固定写法  _$名称FromJson(json) / _$名称ToJson(this)
  factory MusicData.fromJson(Map<String,dynamic> json)=> _$MusicDataFromJson(json);

  Map<String,dynamic> toJson() => _$MusicDataToJson(this);
}