import 'package:flutter_plugins_with_net/http/core/dio_adapter.dart';
import 'package:flutter_plugins_with_net/http/core/http_adapter.dart';
import 'package:flutter_plugins_with_net/http/core/mock_adapter.dart';
import 'package:flutter_plugins_with_net/http/core/net_error.dart';
import 'package:flutter_plugins_with_net/http/request/base_request.dart';
import 'net_adapter.dart';

///描述:网络发起类
///功能介绍:网络发起类
///创建者:翁益亨
///创建日期:2022/5/26 14:01

class Net {
  //缺省参数的构造函数
  Net._();

  //设计单例模式
  static Net? _instance;

  static Net get instance => _instance = _instance ?? Net._();

  //添加当前发送网络请求的方法，异步处理网络信息
  Future<NetResponse<T>> send<T>(
      BaseRequest request, {Map<String, String>? params}) async {
    //通过获取的request发送请求

    //这里只用修改对应的适配器就可做到底层网络请求方式的插拔
    // NetAdapter netAdapter = MockAdapter.getInstance();
    // NetAdapter netAdapter = DioAdapter.getInstance();
    NetAdapter netAdapter = HttpAdapter.getInstance();
    Future<NetResponse<T>> result = netAdapter.send(request, params: params);

    return result;
  }

  //根据当前发送的请求处理返回数据
  Future<T> fire<T>(
      BaseRequest request, {Map<String, String>? params,NetworkErrorCallback? errorCallback}) async {
    var response = await send<T>(request, params:params);

    //处理返回的数据
    int code = response.code ?? 0;
    NetError? error ;//记录当前异常的对象
    switch (code) {
      case 200:
        dynamic result = response.data;
        //请求成功，一定存在数据
        //默认返回的是Map类型 ，所以这里要多做一层转化，转化成实体类
        return result;
      case 401:
        //token失效，需要登录
        error = NeedLogin();
        break;
      default:
        error = NetError(response.code, response.message);
        break;
    }

    //走到这里error一定不为<null>
    //判断是否有正常的回调，如果有就进行回调处理，并且将抛出异常捕获中设置为已经处理的状态
    if(errorCallback != null){
      error.processed = true;//标识当前的异常已经被处理，全局捕获后异常不进行处理
      errorCallback(error.errorCode??0,error.errorMessage??"");
    }

    //抛出异常
    throw error;
  }

}
