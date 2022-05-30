import '../../config/constants.dart';

/// 描述:网络请求的基类
///功能介绍:网络请求的基类
///创建者:翁益亨
/// 创建日期:2022/5/26 10:39

//声明当前http请求支持的类型
enum HttpMethod { get, post, delete }

//区分当前开发/测试/预发/正式环境的域名
enum HttpEnv { dev, test, pre, pro}

//标识当前用户请求的环境
HttpEnv env = HttpEnv.dev;

//获取对应环境的域名
String domainName(){
  switch(env){
    case HttpEnv.dev:
    case HttpEnv.test:
    case HttpEnv.pre:
      return "api.uomg.com";
    case HttpEnv.pro:
      return "api.uomg.com";
    default:
      return "api.uomg.com";
  }
}

//当前是否匹配http链接，根据当前需求匹配数据
bool useHttps(){
  switch(env){
    case HttpEnv.dev:
    case HttpEnv.test:
    case HttpEnv.pre:
      return false;
    case HttpEnv.pro:
      return true;
    default:
      return false;
  }
}

//当前是否匹配http链接，根据当前需求匹配数据
String envType(){
  switch(env){
    case HttpEnv.dev:
      return 'DEV';
    case HttpEnv.test:
      return 'TEST';
    case HttpEnv.pre:
      return 'PRE';
    case HttpEnv.pro:
      return 'RELEASE';
    default:
      return '';
  }
}

//声明抽象类，封装网络请求数据
abstract class BaseRequest{

  //网络请求方式
  //示例<域名： http://www.baidu.com  路径： pic 或 pic/1/2/3 参数：params中添加键值对 get中title=hello 或 post中的body里的键值对>
  //1.http://www.baidu.com/pic?title=hello <get>
  //2.http://www.baidu.com/pic/1/2/3  <get>
  //3.http://www.baidu.com body中传递键值对 <post>


  //定义接收的请求参数，使用隐式的get和set请求，目前确定一定会传递路径
  //_path!表示当前一定存在，处理空判断的一个快捷方式
  String? _path;
  String get path => _path!;
  set path(String? value)=>_path = value ;

  //获取当前请求的类型
  HttpMethod httpMethod();

  //获取当前配置整合的url信息，完整的url链接
  //默认需要携带当前用户的请求令牌，例如：登录时候返回的token
  String url({Map<String, String>? params}){

    Uri uri ;
    //拼接当前的url信息
    //域名+路径返回信息

    //使用Uri.http或者Uri.https构建一个url请求地址
    String requestPath = "${_path!.startsWith('/')?'':'/'}$_path";

    bool useHttp = useHttps();

    if(useHttp){
      uri = Uri.https(domainName(), requestPath,params);
    }else{
      uri = Uri.http(domainName(), requestPath,params);
    }


    return uri.toString();
  }

  //头部header添加
  Map<String, String> headerParams = {};//不推荐使用Map()

  //链式添加当前需要的参数
  //避免token失效后,不会重新填充,每次网络请求需要重新添加 addHeaderParams(Constants.token, '');
  BaseRequest addHeaderParams(String key,dynamic value){
    headerParams[key] = value.toString();
    return this;
  }

  //公共固定头部标题添加
  void initHeaderParams(){
    //当前字段需要扩展适配所有请求，目前就区分get和post请求

    addHeaderParams("charset", "UTF-8");
    addHeaderParams("x-ca-stage", envType());
  }

}