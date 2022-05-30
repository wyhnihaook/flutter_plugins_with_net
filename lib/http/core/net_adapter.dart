import 'dart:convert';

import 'package:flutter_plugins_with_net/http/request/base_request.dart';

import 'net_data_adapter.dart';

///描述:当前网络请求结果适配器
///功能介绍:处理返回结果
///创建者:翁益亨
///创建日期:2022/5/26 15:21

//实现抽象类，用于解耦合网络请求sdk
abstract class NetAdapter {
  Future<NetResponse<T>> send<T>(BaseRequest request,
      {Map<String, String>? params});
}

//请求失败的回调方法定义，请求成功中就直接用then链式调用返回数据即可
//这里的错误回调是用于除了toast以外的其他操作，例如：显示错误信息到界面上
//如果是简单的toast在全局捕获的错误defend_error中就可以进行统一处理
typedef NetworkErrorCallback = Function(int errorCode, String errorMsg);

//响应网络请求实体类
class NetResponse<T> with NetDataAdapter {
  int? code;

  String? message;

  T? data;

  NetResponse({this.code, this.message, this.data});

  //需要将当前获取的数据进行
  //默认data泛型获取时为Map
  NetResponse.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        message = json["message"]
  //data需要通过插件转化为泛型类型
  {
    //这里需要添加将fromJson中data转换的功能,将泛型转化成传递的对应的类型
    //其实内部也只是将泛型可能的类型进行统一的管理,通过获取对应类型名称匹配泛型类型
    // 然后通过生成的fromJson进行Map转对象操作

    //通过json_serializable使用快捷转化数据内容，参考music_data.dart文件
    data = netTypeConvertData(T.toString(), json["data"]);
  }
}
