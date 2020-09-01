import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import '../unitls/global.dart';
import '../network/api_service.dart';
import '../common/common_tool.dart';
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

  //轮播图的点击
  _bannerClick(int index) {
    TopStories model = top_stories[index] ?? null;
    Navigator.of(context).pushNamed("/NewsDetail", arguments: model.url);
  }

  //cell点击
  _itemClick(int index) {
    Stories model = stories[index] ?? null;
    Navigator.of(context).pushNamed("/NewsDetail", arguments: model.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: CustomScrollView(
          slivers: [
            //头部banner
            SliverToBoxAdapter(
              child: Container(
                  height: Global.ksHeight / 2,
                  child: Swiper(
                    itemCount: top_stories?.length ?? 0,
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildBannerWidget(top_stories[index], index);
                    },
                    pagination: SwiperPagination(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(right: 20, bottom: 5)),
                    onTap: _bannerClick,
                  )),
            ),
            //列表
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(_buildListItem,
                  childCount: stories?.length ?? 0),
              itemExtent: itemHeight,
            )
          ],
        ));
  }

  //appBar
  AppBar _buildAppBar() {
      DateTime nowTime = DateTime.now();
    
    return AppBar(
      actions: [
        Container(
          width: Global.ksWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${nowTime.day}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            CommonTool().changeMouth(nowTime.month),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 0.3,
                      height: 35,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        "知乎日报",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                color: Colors.grey,
                icon: Icon(Icons.settings),
                onPressed: () => debugPrint('pressed'),
              ),
            ],
          ),
        )
      ],
      backgroundColor: Color(0xFFf4f5f7),
      elevation: 0,
      brightness: Brightness.light,
    );
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
          Container(
            height: 100,
            padding: EdgeInsets.only(top: 5),
            child: Column(
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
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Stories model = stories[index] ?? [];
    return GestureDetector(
      child: Container(
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
                  margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                  child: Text(
                    model?.title ?? "标题",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, top: 0),
                  child: Text(
                    model?.hint ?? "子标题",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                    maxLines: 1,
                  ),
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
      ),
      onTap: () {
        _itemClick(index);
      },
    );
  }
}
