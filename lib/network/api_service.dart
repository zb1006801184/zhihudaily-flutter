import 'dart:convert';
import '../models/news_model.dart';
import 'package:dio/dio.dart';
import 'http_utils.dart';
import 'api_url.dart';
export '../models/news_model.dart';
class ApiService {
  //获取今日新闻
  static Future<NewsModel> getTodayNews() async {
    Response response =
        await HttpUtils().request(ApiUrl.TODAYNEWS_URL, method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      if (responseData == null) {
        return null;
      }
      return NewsModel.fromJson(responseData);
    } else {
      return null;
    }
  }

static Future<NewsModel> getBeforeDayNews(int day) async {
    Response response =
        await HttpUtils().request('${ApiUrl.BEFORETODAYNEWS_URL}'+'/'+'${day}', method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      if (responseData == null) {
        return null;
      }
      return NewsModel.fromJson(responseData);
    } else {
      return null;
    }
  }


}
