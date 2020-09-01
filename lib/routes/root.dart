import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import '../unitls/global.dart';
import '../network/api_service.dart';
import '../widgets/home_appbar.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  List stories = [];
  List top_stories = [];
  double itemHeight = 80.0;
  EasyRefreshController controller = EasyRefreshController();
  @override
  void initState() {
    super.initState();
    _requestData();
  }

  _requestData() async {
    NewsModel model = await ApiService.getTodayNews();
    setState(() {
      stories = model?.stories ?? [];
      top_stories = model?.topStories ?? [];
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

  _rightAction() {
    print("setting");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppBar().buildAppBar(_rightAction),
        body: EasyRefresh.custom(
          header: MaterialHeader(),
          footer: MaterialFooter(
            overScroll:true,
            enableInfiniteLoad:false,
          ),
          controller: controller,
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
          onRefresh: () async {
            await _requestData();
            controller.resetRefreshState();
          },
          onLoad: () async {
            await _requestData();
            controller.resetLoadState();
          },
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
    return InkWell(
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
