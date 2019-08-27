import 'package:http/http.dart'as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
class Post{
  Post({
    this.title,
    this.pagelink,
    this.imagelink
  });
  final String title;
  final String pagelink;
  final String imagelink;
}

final List<Post> post1234 = [
  Post(
    title: "绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/04c01.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16b01.jpg'"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16d02.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16a02.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16b02.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/08/01d03.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16d03.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16a03.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16b03.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/08/01d04.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16b03.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/08/01d04.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16d03.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16d03.jpg"),
    Post(
    title: "高跟黑丝让人垂涎欲滴 绝色美女黄楽然倾倒万千宅男",
    pagelink: "https://www.mzitu.com/189798",
    imagelink: "https://i.meizitu.net/2019/06/16d03.jpgs"),
];


//得到相关的封面和内容以及跳转信息
class PictureLink {
  List<Post> data = [];
  String url = "https://www.mzitu.com/";
  int page = 1;
  var header = {
  'user-agent' : 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) '+
  'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36',
};

  request_data(pagenum) async {
    page = pagenum;
    data.clear();
    url = "https://www.mzitu.com/page/${pagenum}";
    //print(url);
    var response = await http.get(url,headers: header);
    //print("Staus${response.body}");
    if(response.statusCode == 200){
      var html = response.body;
      Document document = parse(html);
      // 这里使用css选择器语法提取数据
      List<Element> images = document.querySelectorAll('#pins > li > a > img');
      //print(images.length);
      List<Element> page = document.querySelectorAll('#pins > li > a');
      if(images.isNotEmpty){
        data = List.generate(images.length, (i){
          print(images[i].attributes['alt']);
          //print(page[i].attributes['href']);
          //print(images[i].attributes['data-original']);
        return Post(
          title: images[i].attributes['alt'],
          pagelink: page[i].attributes['href'],
          imagelink: images[i].attributes['data-original']); 
        });
        return data;
     }
    }
    return data.clear();
  }

    getmore_picture() async {
      return await request_data(page+1);
    }
  }

  class GetAllPicture{
    final String url;
    GetAllPicture({this.url});
    int picturenum;
    int num;
    var header = {
  'user-agent' : 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) '+
  'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36',
  };
  List<String> AllPicturelink = [];

    getalllink() async {
      var content = await http.get(url,headers: header);
      Element data ;
      if(content.statusCode == 200){
        var html = content.body;
        Document document = parse(html);
        data = document.querySelector("body > div.main > div.content > div.pagenavi > a:nth-child(7) > span");
        var firstpicturelink = document.querySelector("body > div.main > div.content > div.main-image > p > a > img").attributes["src"];
        AllPicturelink.add(firstpicturelink);
        //print(data.text);
      }
      picturenum = int.parse(data.text);
      for(int i= 2; i<5; i++){
        var pictureurl = "${url}/${i}";
        print(pictureurl);
        var finalcontent = await http.get(pictureurl,headers: header);
        if(finalcontent.statusCode == 200){
        var html = finalcontent.body;
        Document document = parse(html);
        var data = document.querySelector("body > div.main > div.content > div.main-image > p > a > img").attributes["src"];
        print(data);
        AllPicturelink.add(data);
        num = i;
        //print(data.text);
      }
      
      }
      return AllPicturelink;
      //return 100;
    }

    getmore() async {
      AllPicturelink.clear();
      int a;
      for(int i= num+1; i<num+5; i++){
        var pictureurl = "${url}/${i}";
        print('请求${pictureurl}');
        var finalcontent = await http.get(pictureurl,headers: header);
        if(finalcontent.statusCode == 200){
        var html = finalcontent.body;
        Document document = parse(html);
        var data = document.querySelector("body > div.main > div.content > div.main-image > p > a > img").attributes["src"];
        print(data);
        AllPicturelink.add(data);
        a = i;
        //print(data.text);
      }
      
    }
    num = a;
    return AllPicturelink;
  }
  }