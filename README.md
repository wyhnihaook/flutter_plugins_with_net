# flutter_plugins_with_net
flutter的网络请求封装  

项目中集成了http和dio插件，用于展示热插拔的效果。（随时替换第三方网络请求框架）   
在net.dart文件中，通过切换http和dio以及mock的适配器，直接进行网络请求切换  
一般网络异常在lib/util/defend_error.dart文件中统一捕获处理  
网络返回code异常，通过判断当前请求是否自身处理进行过滤，通过传递NetworkErrorCallback实现  
## 使用方式：参考main.dart中的_incrementCounter方法
## 推荐使用dio网络框架
内部维护了http框架没有维护的内容  
例如：拦截器，自定义异常等...
## 使用须知
在使用泛型转化对象时，需要手动或使用三方库自动生成对应的data对象  
然后必须在net_data_adapter.dart文件中进行声明  
在转化时，会根据T.toString()获取当前泛型需要转化类型的名称，去转化类中匹配，做对应数据处理  
