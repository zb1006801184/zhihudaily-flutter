import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import '../unitls/global.dart';
import '../unitls/nav_bar_config.dart';
import '../network/api_service.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  List stories = [];
  List top_stories = [];
  double itemHeight = 80.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestData();
  }

  _requestData() async {
    NewsModel model = await ApiService.getTodayNews();
    setState(() {
      stories = model.stories;
      top_stories = model.topStories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBarConfig().configAppBar("晚上好！！"),
        body: CustomScrollView(
          slivers: [
            //头部banner
            SliverToBoxAdapter(
              child: Container(
                  height: Global.ksHeight / 2,
                  child: Swiper(
                    itemCount: top_stories?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildBannerWidget(top_stories[index], index);
                    },
                  )),
            ),
            //列表
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(_buildListItem,
                    childCount: stories?.length ?? 0),
                itemExtent: itemHeight)
          ],
        ));
  }

//轮播图的内容
  Widget _buildBannerWidget(TopStories model, int index) {
    return Container(
      decoration: new BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(model.image), fit: BoxFit.fill)),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              height: 100,
              color: Colors.black,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  model?.title ?? "轮播图标题",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 21),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 8),
                child: Text(
                  model?.hint ?? "作者",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Stories model = stories[index] ?? [];
    return Container(
      height: itemHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, top: 15),
                child: Text(
                  model?.title ?? "标题",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, top: 0),
                child: Text(model?.hint ?? "子标题",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ),
            ],
          )),
          Container(
            margin: EdgeInsets.only(right: 16),
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(2),
              image: DecorationImage(
                  image: NetworkImage(
                    model?.images[0] ?? "",
                  ),
                  fit: BoxFit.fill),
            ),
          )
        ],
      ),
    );
  }
}
