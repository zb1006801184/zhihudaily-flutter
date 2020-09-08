import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zhihudaily_flutter/common/common_tool.dart';
import 'package:zhihudaily_flutter/unitls/global.dart';
import 'package:zhihudaily_flutter/unitls/them_util.dart';
import '../unitls/global.dart';
import '../network/api_service.dart';
import '../unitls/global.dart';
import '../unitls/global.dart';
import '../widgets/home_appbar.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  List stories = [];
  List top_stories = [];
  double itemHeight = 80.0;
  DateTime timeDay = DateTime.now().add(Duration(days: 1));
  EasyRefreshController controller = EasyRefreshController();
  @override
  void initState() {
    super.initState();
    _requestData();
  }

  _requestData() async {
    NewsModel model = await ApiService.getTodayNews();
    timeDay = DateTime.now().add(Duration(days: 1));
    stories.clear();
    setState(() {
      stories.addAll(model?.stories ?? []);
      top_stories = model?.topStories ?? [];
    });
  }

  _requestBeforeDayData() async {
    timeDay = timeDay.add(Duration(days: -1));

    NewsModel model =
        await ApiService.getBeforeDayNews(int.parse(_changeDate(timeDay)));
    stories.add(model?.date);
    setState(() {
      stories = stories + model?.stories;
    });
  }

  String _changeDate(DateTime timeDay) {
    String tem = '${timeDay.year}';
    if (timeDay.month < 10) {
      tem = tem + '0' + '${timeDay.month}';
    } else {
      tem = tem + '${timeDay.month}';
    }
    if (timeDay.day < 10) {
      tem = tem + '0' + '${timeDay.day}';
    } else {
      tem = tem + '${timeDay.day}';
    }
    return tem;
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
    Navigator.of(context).pushNamed("/Mine");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HomeAppBar().buildAppBar(_rightAction, context),
        body: EasyRefresh.custom(
          header: MaterialHeader(),
          footer: MaterialFooter(
            overScroll: true,
            enableInfiniteLoad: false,
          ),
          controller: controller,
          slivers: [
            //头部banner
            SliverToBoxAdapter(
              child: Container(
                  height: Global.ksHeight / 2,
                  child: Swiper(
                    itemCount: top_stories?.length ?? 0,
                    autoplay: top_stories.length > 0 ? true : false,
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
            await _requestBeforeDayData();
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
          Container(
            height: 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(CommonTool.getColorFromHex(model.imageHue)),
                Colors.transparent
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 8),
                  child: Text(
                    model?.title ?? "轮播图标题",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 21),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 20),
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
    var model = stories[index] ?? [];
    if (model is String) {
      return Container(
        width: Global.ksWidth,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text('${model.substring(4,6)}'+'月'+'${model.substring(6,8)}'+'日'),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              color: ThemUntil().widgetColor(context),
              height: 0.2,
            ))
          ],
        ),
      );
    }
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    width: 55,
                    height: 55,
                    imageUrl: model?.images[0] ?? '',
                    placeholder: (context, url) =>
                        Image.asset('images/placeholder_img.png'),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ))
          ],
        ),
      ),
      onTap: () {
        _itemClick(index);
      },
    );
  }
}
