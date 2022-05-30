# flutter_plugins_with_net
flutter的网络请求封装  

项目中集成了http和dio插件，封装后，做到热插拔功能   
在net.dart文件中，通过切换http和dio以及mock的适配器，直接进行网络请求切换  
一般网络异常在util/defend_error.dart文件中统一捕获处理  
网络返回code异常，通过判断当前请求是否自身处理进行过滤，通过传递NetworkErrorCallback实现  
## 使用方式：参考main.dart中的_incrementCounter方法
