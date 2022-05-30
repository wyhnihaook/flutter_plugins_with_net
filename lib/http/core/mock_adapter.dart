import 'package:flutter_plugins_with_net/http/core/net_adapter.dart';
import 'package:flutter_plugins_with_net/http/core/net_data_adapter.dart';
import 'package:flutter_plugins_with_net/http/request/base_request.dart';

///描述:模拟数据请求的适配器
///功能介绍:模拟数据请求的适配器
///创建者:翁益亨
///创建日期:2022/5/26 15:28
class MockAdapter extends NetAdapter with NetDataAdapter{

  MockAdapter._();
  static MockAdapter? _instance;
  static MockAdapter getInstance(){
    return _instance??=MockAdapter._();
  }

  @override
  Future<NetResponse<T>> send<T>(BaseRequest request, {Map<String, String>? params}) {
    return Future<NetResponse<T>>.delayed(const Duration(seconds:2),(){
      //模拟数据请求2s返回

      //这里要对应数据处理
      return NetResponse(code: 200,message: "请求成功",
          data: netTypeConvertData(T.toString(),
              convertBaseData(T.toString())));
    });
  }

  //模拟默认数据内容
  dynamic convertBaseData(String type){

    //只用处理普通数据类型默认模拟返回值
    switch(type){
      case "String":
        return "";

      case "int":
        return 0;

      case "bool":
        return false;
    }

    return {};
  }
}