import 'package:flutter_plugins_with_net/http/model/music_data.dart';
import 'package:flutter_plugins_with_net/http/request/base_request.dart';

import '../core/net.dart';
import '../core/net_adapter.dart';
import '../model/app_image_data.dart';

///描述:网络请求api统一管理
///功能介绍:网络请求api统一管理
///创建者:翁益亨
///创建日期:2022/5/26 13:59
class ApiPostRequest extends BaseRequest{

  //设计单例模式
  ApiPostRequest._(){
    initHeaderParams();
    addHeaderParams("content-type", "application/x-www-form-urlencoded");
  }

  static ApiPostRequest? _instance;
  static ApiPostRequest getInstance(){
    return _instance??=ApiPostRequest._();
  }

  @override
  HttpMethod httpMethod() {
    return HttpMethod.post;
  }


  //当前测试请求数据
  Future<MusicData> getAppImage({NetworkErrorCallback? errorCallback}){
    //路径处理
    path = "api/rand.music";
    Map<String,String> params = {
      "sort":"热歌榜",
      "format":"json",
    };

    return Net.instance.fire<MusicData>(this,params: params,errorCallback:errorCallback);
  }

}