///描述:接口请求返回对象
///功能介绍:手动转化当前数据
///创建者:翁益亨
///创建日期:2022/5/26 19:40
class AppImageData{

   String? name;

   String? url;

   String? picurl;

   String? artistsname;

   AppImageData({this.name, this.url, this.picurl,
    this.artistsname});


   AppImageData.fromJson(Map<dynamic,dynamic> map):name = map["name"],
         url = map["url"],picurl = map["picurl"],
         artistsname = map["artistsname"];

  Map<dynamic,dynamic> toJson(){
    return {"name":name,"url":url,
      "picurl":picurl,"artistsname":artistsname};
  }
}