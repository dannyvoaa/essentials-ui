import 'dart:convert';

import 'package:aae/model/news_feed.dart';
import 'package:aae/model/serializers.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

///
/// Returns [NewsFeed] with complete [NewsFeed] response.
///
class NewsServiceApi {
  static final Logger _log = Logger('AAE NewsFeed API Client');
  final http.Client httpClient = http.Client();

  String baseUrl =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/default/am-newsfeedservice.json';

  Future<NewsFeed> getNewsFeed() async {
    final response = await httpClient.get(baseUrl).then((http.Response r) => r);
    if (response.statusCode == 200) {
      _log.info("Newsfeed API request successful");
      NewsFeed feed = serializers.deserializeWith(
          NewsFeed.serializer, json.decode(response.body));
      return feed;
    } else {
      throw Exception(
          'Failed to load the news feed\n ${response.body} - ${response.statusCode}');
    }
  }
}
