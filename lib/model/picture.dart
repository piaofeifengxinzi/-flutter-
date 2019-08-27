import 'package:flutter/material.dart';
import 'package:picturetest/model/post.dart';


class picture extends StatefulWidget{
  final String url;
  picture({Key key,this.url}):super(key:key);
  @override
  AllPicture createState() => AllPicture(url:url);
}

class AllPicture extends State<picture>{

  Map<String,String> headers (refer){
      Map<String,String> headers ={
        'Host': 'i.meizitu.net',
        'Pragma': 'no-cache',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) '
                      'Chrome/59.0.3071.115 Safari/537.36',
        'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
        'Referer': '{${refer}}',
    };
    return headers;
 }
  
  AllPicture({@required this.url});
  final String url;
  
  var data;
  List<String> picturelist = [];
  GetAllPicture getAllPicture;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(
        itemCount: picturelist.length,
        itemBuilder: (context,index){
          print(index);
          print(picturelist.length);
          if(index+1 == picturelist.length){
            print("执行获取更多");
            getmore();
          }
          if(picturelist.isEmpty){
            print("执行空");
            return null;
          }
          print("执行链接${picturelist[index]}${index}");
          return Container(
            child: Image.network(picturelist[index],
            headers:headers(picturelist[index])
            )
          );
        },
      ),
    );
  }
  getdata() async {
    //data = 1234;
    var dat = await getAllPicture.getalllink();
    setState(() {
     for(var x in dat){
      picturelist.add(x);
    } 
    });
  }

  getmore() async {
    //print("zhixing");
    try{
      var date = await getAllPicture.getmore();
    setState(() {
      for(var x in date){
        print(x);
      picturelist.add(x);
    }
    });
    }catch(e){

    }
  }


  @override
  void initState(){
    super.initState();
    getAllPicture = new GetAllPicture(url:url);
    //获取所有的图片的地址，或者只获取一部分的地址以加快响应速度
    getdata();
  }

}