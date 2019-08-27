import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:picturetest/model/picture.dart';
import 'post.dart';
import 'package:fluttertoast/fluttertoast.dart';




class GridPage extends StatefulWidget {
  @override
  GridPageState createState() => new GridPageState();
}

class GridPageState extends State<GridPage> with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = new ScrollController();
  PictureLink pictureLink = new PictureLink();
  int _page = 0;
  int _size = 10;
  int _beLoad = 0; // 0表示不显示, 1表示正在请求, 2表示没有更多数据

  var posts = [];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Container(
        color: Colors.grey[100],
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          itemCount: posts.length,
          primary: false,
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          itemBuilder: (context, index) {
            print("pubu${index}");
            return TileCard(
              title: posts[index].title,
              imagelink: posts[index].imagelink,
              pagelink: posts[index].pagelink,);
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  // 下拉刷新数据
  Future<Null> _refreshData() async {
    _page = 0;
    _getPostData(false);
  }

  // 上拉加载数据
  Future<Null> _addMoreData() async {
    _page++;
    _getPostData(true);
  }

  void _getPostData(bool _beAdd) async {
    var link = await pictureLink.getmore_picture();
    setState(() {
      if (!_beAdd) {
        posts.clear();
        posts = null;
      } else {
        for(var x in link){
          print("pubushuju${x.title}");
          posts.add(x);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // 首次拉取数据
    _getPostData(true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _addMoreData();
        print('我监听到底部了!');
      }
    });
  }
}

class TileCard extends StatelessWidget {
  //Post post;
  final String title;
  final String imagelink;
  final String pagelink;
  TileCard({Key key,this.title,this.imagelink,this.pagelink}):super(key:key);

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
          return picture(url:pagelink);
        }
        )
        );
      },
      child:  Card(
        child: Column(
          children: <Widget>[
            Image.network(imagelink,headers: headers(imagelink),),
            Text(title)
          ],
        ),
      )
    ,);
  }
}
