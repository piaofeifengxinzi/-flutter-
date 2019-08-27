


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturetest/model/pubu.dart';


import 'model/post.dart';
import 'model/mzitu.dart';



void main () async
{
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '妹子图',
      home:Home1(),
      theme: ThemeData(
        primaryColor: Colors.yellow
      ),
    );
  }
}


class Home1 extends StatelessWidget{
  List<Post> posts;
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
      child:Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        
        title: Text("appbartitle"),
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.search),
          tooltip: "search",
          onPressed: ()=>debugPrint("search button is pressed."),
        ),
        IconButton(
          icon: Icon(Icons.more_horiz),
          tooltip: "search",
          onPressed: ()=>debugPrint("search button is pressed."),
        ),
        ],
        elevation: 0.0,
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.list),),
            Tab(icon: Icon(Icons.change_history),),
            Tab(icon: Icon(Icons.directions_transit),),
            
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          MyHomePage(),
          //Icon(Icons.list, size: 128.0, color: Colors.green),
          GridPage(),
          //Icon(Icons.change_history, size: 128.0,color: Colors.red,),
          Icon(Icons.directions_transit, size: 128.0, color: Colors.green,)
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("UerHeader".toUpperCase()),
              decoration: BoxDecoration(
                color: Colors.grey[100]
              ),
            ),
            ListTile(
              title: Text("message",textAlign: TextAlign.right,),
              trailing: Icon(Icons.message,color: Colors.black12,size:22.0),
            ),
            ListTile(
              title: Text("favorite",textAlign: TextAlign.right,),
              trailing: Icon(Icons.favorite,color: Colors.black12,size:22.0),
            ),
            ListTile(
              title: Text("settings",textAlign: TextAlign.right,),
              trailing: Icon(Icons.settings,color: Colors.black12,size:22.0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text("Explore")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("History")
          )
            
        ],
      ),
      ) ,
    );
  }
}



//这是一个实验性的列表，没有使用到
class Home extends StatelessWidget{
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
  Widget _listBuilder(BuildContext context, int index){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Image.network(post1234[index].imagelink,
          headers: headers(post1234[index].imagelink),),
          SizedBox(height: 16.0,),
          Text(post1234[index].title,style: Theme.of(context).textTheme.title,),
          Text(post1234[index].pagelink,style: Theme.of(context).textTheme.subhead,),
          SizedBox(height: 16.0,),
        ],
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("appbar"),
        ),
        body: ListView.builder(
          itemCount: post1234.length,
          itemBuilder: _listBuilder,
        ),
        );
  }
}





