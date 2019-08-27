import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'post.dart';


//妹子图的列表，返回的是一个列表
class MyHomePage extends StatefulWidget{
  List <Post> posts;
  

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  bool loading = false;
  PictureLink pictureLink = new PictureLink();
  var page = 1;
  var isfirst = true;
  var link;
  List <Post> posts = [];
  
  Map<String,String> headers (refer){
      Map<String,String> headers ={
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) '
                      'Chrome/59.0.3071.115 Safari/537.36',
        'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
        'Referer': '{${refer}}',
    };
    return headers;
 }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context,index){
          if(index+5 == posts.length&&posts.length != 0){
            //print("当前数字大于列表长度");
            loadpicture();
            return Container(
              color: Colors.white,
              margin: EdgeInsets.all(8.0),
              child: 
                  Image.network(posts[index].imagelink,
                  headers: headers(posts[index].imagelink),
                  fit: BoxFit.fitHeight,),
                  //SizedBox(height: 16.0,),
                  //Text(posts[index].title,style: Theme.of(context).textTheme.title,),
                  //Text(posts[index].pagelink,style: Theme.of(context).textTheme.subhead,),
                  //SizedBox(height: 16.0,),  
    );
          }else if(index > posts.length)
          {
            return null;  
          }
          return Container(
              color: Colors.black,
              margin: EdgeInsets.all(0.0),
              child: 
                  Image.network(posts[index].imagelink,
                  headers: headers(posts[index].imagelink),
                  fit: BoxFit.fitHeight,),
                  //SizedBox(height: 16.0,),
                  //Text(posts[index].title,style: Theme.of(context).textTheme.title,),
                  //Text(posts[index].pagelink,style: Theme.of(context).textTheme.subhead,),
                  //SizedBox(height: 16.0,),
        
    );

        },
      ),
    );
  }

  loadpicture() async {
    if(loading){
      return null;
    }
    loading = false;
    if(isfirst){
      loading = true;
      link = await pictureLink.request_data(1);
      loading = false;
      isfirst = false;
    }else{  
      loading = true;
      link = await pictureLink.getmore_picture();
      loading = false;
    }   
    setState(() {
      for(var x in link){
        //print("添加到列表${x.title}");
        posts.add(x);
      }
    });
    }

    firstload() async{
      link = await pictureLink.request_data(1);
      setState(() {
      for(var x in link){
        //print("firstload加载${x.title}");
        posts.add(x);
      }
    });
    }

    @override
    void initState() {
      super.initState();
      firstload();
    } 

  }