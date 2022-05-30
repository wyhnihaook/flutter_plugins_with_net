///描述:当前异常处理封装->需要额外操作的错误码封装
///功能介绍:创建自身定义的异常类型，例如：token失效等
///创建者:翁益亨
///创建日期:2022/5/26 15:59

//需要退出登录异常定义
class NeedLogin extends NetError {
  NeedLogin({int errorCode = 401, String errorMessage = "重新登录"})
      : super(errorCode, errorMessage);
}

//异常基类
class NetError implements Exception {
  final dynamic data; //要额外获取数据进行异常处理

  final int? errorCode; //错误码

  final String? errorMessage; //提示信息

  //标识是否已处理，默认异常需要抛出到全局处理，但是部分异常是针对页面上的显示问题，所以在有异常回调时，全局异常不处理当前事件
  bool processed = false;

  //一定有异常的message，兼容普通异常
  NetError(this.errorCode, this.errorMessage, {this.data});
}
