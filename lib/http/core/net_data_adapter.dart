import 'package:flutter_plugins_with_net/http/model/app_image_data.dart';

import '../model/music_data.dart';

///描述:当前内容转化的适配器
///功能介绍:网络请求返回的data结构类型处理,所有类型数据都要在此申明,为了结合泛型内容
///创建者:翁益亨
///创建日期:2022/5/27 10:35

mixin NetDataAdapter{

  ///!!!!重要!!!!
  ///这里需要区分额外情况,当前data就返回普通一个数据类型,bool或者String或者num等
  dynamic netTypeConvertData(String type,dynamic data){

    switch(type){
      case "AppImageData":
        return AppImageData.fromJson(data);
      case "MusicData":
        return MusicData.fromJson(data);
      default:
        //默认情况返回格式即可
        return data;
    }
  }

}