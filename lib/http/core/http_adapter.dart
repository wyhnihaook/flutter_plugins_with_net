import 'dart:convert';

import 'package:flutter_plugins_with_net/http/core/net_adapter.dart';
import 'package:flutter_plugins_with_net/http/request/base_request.dart';
import 'package:http/http.dart' as http;

///描述:第三方网络请求http的适配器
///功能介绍:
///创建者:翁益亨
///创建日期:2022/5/30 10:01
class HttpAdapter extends NetAdapter {
  HttpAdapter._();

  static HttpAdapter? _instance;

  static HttpAdapter getInstance() {
    return _instance ?? HttpAdapter._();
  }

  @override
  Future<NetResponse<T>> send<T>(BaseRequest request,
      {Map<String, String>? params}) async {

    //异常直接抛出，http插件内部不会抛出自定义异常

    //请求返回情况
    http.Response? response;

    //当前网络异常会在http的方法调用时抛出，例如：SocketException等，不需要拦截处理，可以在全局异常进行类型异常区分即可
    //区分当前请求类型
    if (request.httpMethod() == HttpMethod.get) {
      response = await http.get(Uri.parse(request.url(params: params)),
          headers: request.headerParams);
    } else if (request.httpMethod() == HttpMethod.post) {
      response = await http.post(Uri.parse(request.url()),
          body: params, headers: request.headerParams);
    } else if (request.httpMethod() == HttpMethod.delete) {
      response = await http.delete(Uri.parse(request.url()),
          body: params, headers: request.headerParams);
    }

    //这里要注意，在参数后添加！标识当前参数一定不为null，使用之后，后续继续使用该参数就不需要添加！
    response = response!;

    //充当request输出拦截器，输出当前request信息
    print(response.request);

    //根据返回的数据做返回数据处理，由于当前返回的是body字符串，所以这里要进行json解析转化
    //首先将字符串转化为Map，然后再对原来的数据分析,理论上response一定存在

    //这里<可能>会返回map解析异常的内容，jsonDecode方法调用异常 FormatException
    //或者data返回异常

    Map<String, dynamic> result = jsonDecode(response.body);

    //这里进行code解析
    //充当response拦截器的功能
    print(result);

    if (result["code"] == 1) {
      //请求成功信息
      result["code"] = 200;

      //模拟异常信息
      // result["code"] = 100;
      // result["msg"] = "请求模拟异常";
    }

    if(result["code"] != 200){
      //请求结果返回问题，进行当前的数据模拟构建
      return NetResponse(code: result["code"], message: result["msg"]);
    }

    return buildResponse(result);
  }

  //构建返回的数据结构
  NetResponse<T> buildResponse<T>(Map<String, dynamic> result) {
    return NetResponse<T>.fromJson(result);
  }


}
