import 'package:flutter_plugins_with_net/http/core/net_adapter.dart';
import 'package:flutter_plugins_with_net/http/request/base_request.dart';

import '../core/net.dart';
import '../model/app_image_data.dart';

///描述:网络请求api统一管理
///功能介绍:网络请求api统一管理
///创建者:翁益亨
///创建日期:2022/5/26 13:59
class ApiGetRequest extends BaseRequest{

  //设计单例模式
  ApiGetRequest._(){
    initHeaderParams();
    addHeaderParams("content-type", "application/json");
  }

  static ApiGetRequest? _instance;
  static ApiGetRequest getInstance(){
    return _instance??=ApiGetRequest._();
  }

  @override
  HttpMethod httpMethod() {
    return HttpMethod.get;
  }


  //当前测试请求数据
  Future<AppImageData> getAppImage(){
    //路径处理
    path = "api/rand.music";
    Map<String,String> params = {
      "sort":"热歌榜",
      "format":"json",
    };

    return Net.instance.fire<AppImageData>(this,params: params);
  }

}