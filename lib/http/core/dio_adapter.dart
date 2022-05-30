import 'package:dio/dio.dart';
import 'package:flutter_plugins_with_net/http/core/net_adapter.dart';
import 'package:flutter_plugins_with_net/http/core/net_error.dart';
import 'package:flutter_plugins_with_net/http/request/base_request.dart';

///描述:第三方网络请求dio的适配器
///功能介绍:
///创建者:翁益亨
///创建日期:2022/5/26 16:26
class DioAdapter extends NetAdapter{

  //设置单例模式,保证Dio对象不被多次创建

  static DioAdapter? _instance;
  static DioAdapter getInstance(){
    return _instance??=DioAdapter._();
  }

  final dio = Dio();

  DioAdapter._(){
    //设置当前额外的配置(拦截器)
    dio.interceptors.add(DioInterceptor());
  }

  @override
  Future<NetResponse<T>> send<T>(BaseRequest request, {Map<String, String>? params}) async{
    //对请求方式做区分，并且做对应的处理信息

    //网络返回的数据
    Response? response ;

    //错误信息统计
    DioError? error;

    //当前网络请求的基本配置，同步网络请求信息,传递的参数可能有出入,所以这里不做其他操作
    var options = Options(headers: request.headerParams);

    //这里需要捕获异常，dio网络层封装的异常处理
    try{

      //判断当前请求的方式
      if(request.httpMethod() == HttpMethod.get){

        //get请求方式,params存在拼接方式
         response = await dio.get(request.url(params: params),options:options);

      }else if(request.httpMethod() == HttpMethod.post){

        //post请求方式，params存在进行参数添加
        response = await dio.post(request.url(),data:params,options:options);

      }else if(request.httpMethod() == HttpMethod.delete){

        response = await dio.delete(request.url(),data:params,options:options);

      }

    }on DioError catch (e){
      error = e;
      response = e.response;
    }


    if(error != null){
      //抛出当前异常
      Response errorResponse =  response as Response;

      //请求失败的异常信息,不是服务端返回的,直接将错误码以及错误信息抛出即可
      throw NetError(errorResponse.statusCode, errorResponse.statusMessage);
    }

    //服务端返回的正常数据

    //response中的大部分参数是http网络请求的返回数据,只有data才是我们关心的内容
    //走到这里说明网络请求是成功的,那么我们就直接转化对应的解析对象data ->  NetResponse

    //走到这里response保证不为空，所以添加后缀!
    return buildResponse(response!);
  }


  NetResponse<T> buildResponse<T>(Response response){
    //正常返回数据,直接反向解析内容data赋值,请求成功默认一定会返回对应的服务端数据,这里不做额外处理
    //默认返回数据内容的data为Map结构
    return NetResponse<T>.fromJson(response.data);
  }
}


///dio的拦截器处理,按需实现
class DioInterceptor extends Interceptor{

  //参照当前的拦截器内容

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler){

    //输出请求的信息
    print("dio request :${options.uri.toString()}");
    print("dio request params :${options.data.toString()}");

    handler.next(options);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler){
    //输出请求返回的信息

    //直接输出等同于response.data.因为Response对象中输出的信息为response.data

    //使用当前的接口返回成功的是1，处理成想要的内容，转化成200
    //可以在这里模拟处理当前网络请求返回错误码的情况
    if(response.statusCode == 200){
      if( response.data["code"] == 1){
          response.data["code"] = 200;
      }

      //模拟请求异常
      // if( response.data["code"] == 1){
      //   response.data["code"] = 1;
      //   response.data["message"] = "没有检索到对应数据";
      // }
    }

    print("dio response :${response}");

    handler.next(response);
    }

  @override
  void onError(
      DioError err,
      ErrorInterceptorHandler handler){
    //输出错误信息

    // 示例:DioError [DioErrorType.other]: SocketException: Failed host lookup: '域名信息' (OS Error: No address associated with hostname, errno = 7)
    print("dio err :$err");

    handler.next(err);
  }
}