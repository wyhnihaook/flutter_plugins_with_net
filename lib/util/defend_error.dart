import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_plugins_with_net/http/core/net_error.dart';

///描述:捕获全局中未捕获的异常情况
///功能介绍:提供扩展性,用于第三方或本地异常上报
///创建者:翁益亨
///创建日期:2022/5/27 11:10

class DefendError{
  void runAppPage(Widget app){

    //依赖的第三方框架中的异常捕获
    FlutterError.onError = (FlutterErrorDetails details) async{
      //将异常同步到当前runZonedGuarded中捕获
      Zone.current.handleUncaughtError(details.exception, details.stack??StackTrace.empty);

      //正常抛出异常
      // FlutterError.dumpErrorToConsole(details);
    };

    //App内自身实现方法未捕获的异常上报入口
    runZonedGuarded((){
      runApp(app);
    },(e,s){
      _reportError(e,s);
    });

  }

  void _reportError(Object e, StackTrace s) {
    //可以声明当前是否是正式环境做区分

    if(e is NeedLogin){
      print("登录失效");
      return;
    }

    if(e is NetError){
      if(!e.processed){
        print("自定义网络异常等待处理中....code ${e.errorCode} message ${e.errorMessage}");
      }else{
        print("自定义网络异常已经被处理");
      }

      return;
    }

    //todo 暂不处理环境区分
    print("defend error : $e");
  }


}