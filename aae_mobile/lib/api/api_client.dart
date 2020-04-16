import 'dart:convert';

import 'package:aae/model/docs.dart';
import 'package:aae/model/event.dart';
import 'package:aae/model/news_article.dart';
import 'package:aae/model/news_feed.dart';
import 'package:aae/model/performance_stats.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/model/profile_query.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/stock_stats.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

///
/// Returns [NewsFeed] with complete [NewsFeed] response.
///
// TODO: (kiheke) - Refactor when APIs are behind protected endpoint.
class NewsServiceApi {
  static final Logger _log = Logger('AAE NewsFeed API Client');
  final http.Client httpClient = http.Client();

  final baseUrl =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/default/ae-newsfeed.json?tag=';

  final preferencesEndpoint =
      'https://toreetherywhimandifersee:55608bd3e3255fe1851de225ce562d4cab7d8fa2@b23661f9-9acc-4aab-9a2b-f8aa0f41b993-bluemix.cloudantnosqldb.appdomain.cloud/user_preferences/_find';
  final eventsEndpoint =
      'https://beredididleatecturingele:457299efd6f5f57dbd679a0362d377a1ccf5018a@b23661f9-9acc-4aab-9a2b-f8aa0f41b993-bluemix.cloudantnosqldb.appdomain.cloud/events/_find';

  // TODO (rpaglinawan): implement with live endpoint
  final stocksEndpoint =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/default/AALStock.json';

  final performanceEndpoint =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/default/PerformanceStats.json';

  final articleEndpoint =
      'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/default/ae-newsarticle.json?contentID=';

  Future<List<NewsFeed>> getNewsFeed(List<String> tags) async {
    List<NewsFeed> feedList = <NewsFeed>[];
    for (var tag in tags) {
      final response = await httpClient
          .get('$baseUrl$tag&count=15&page=0')
          .then((http.Response r) => r);
      if (response.statusCode == 200) {
        _log.info("Newsfeed API request successful");
        NewsFeed feed = serializers.deserializeWith(
            NewsFeed.serializer, json.decode(response.body));
        feedList.add(feed);
      } else {
        throw Exception(
            'Failed to load the news feed\n ${response.body} - ${response.statusCode} - $tag');
      }
    }
    return feedList;
  }

  Future<Profile> getProfile(String aaId) async {
    final headers = {'content-type': 'application/json'};

    final body = jsonEncode({
      "selector": {
        "aaId": {"\$eq": aaId}
      },
      "fields": ["preferences"],
      "sort": [
        {"aaId": "asc"}
      ]
    });

    final response = await httpClient
        .post(preferencesEndpoint, headers: headers, body: body)
        .then((http.Response r) => r);
    if (response.statusCode == 200) {
      ProfileQuery profileQuery =
          ProfileQuery.fromJson(jsonDecode(response.body));

      Profile profile = Profile((b) => b
        ..topics.addAll(profileQuery.docs[0].preferences.topics)
        ..location = profileQuery.docs[0].preferences.location
        ..workgroup.addAll(profileQuery.docs[0].preferences.workgroup));

      print(profile);

      _log.info("Profile request successful");
      return profile;
    } else {
      throw Exception(
          'Failed on profile request \n ${response.body} - ${response.statusCode}');
    }
  }

  Future<Docs> getEvents(DateTime query) async {
    final headers = {'content-type': 'application/json'};

    final body = jsonEncode({
      "selector": {
        "\$and": [
          {
            "startDay": {"\$eq": query.day},
            "startMonth": {"\$eq": query.month},
            "startYear": {"\$eq": query.year}
          }
        ]
      },
      "fields": [],
      "sort": []
    });

    final response = await httpClient
        .post(eventsEndpoint, headers: headers, body: body)
        .then((http.Response r) => r);
    if (response.statusCode == 200) {
      Docs query = serializers.deserializeWith(
          Docs.serializer, json.decode(response.body));

      _log.info("Events request successful");
      _log.shout('dataQuery: $query');
      return query;
    } else {
      throw Exception(
          'Failed on events request \n ${response.body} - ${response.statusCode}');
    }
  }

  Future<List<Event>> getDaysWithEvents(DateTime month) async {
    final headers = {'content-type': 'application/json'};

    final body = jsonEncode({
      "selector": {
        "startYear": {"\$eq": month.year},
        "startMonth": {"\$gte": month.month},
        "endMonth": {"\$lte": month.month},
      },
      "fields": [],
      "sort": [
        {"allDay:number": "asc"},
        {"start:number": "asc"},
        {"eventName:string": "asc"}
      ]
    });

    final response = await httpClient
        .post(eventsEndpoint, headers: headers, body: body)
        .then((http.Response r) => r);
    if (response.statusCode == 200) {
      Docs query = serializers.deserializeWith(
          Docs.serializer, json.decode(response.body));

      _log.info("Events request successful");
      return query.events.toList();
    } else {
      throw Exception(
          'Failed on events request \n ${response.body} - ${response.statusCode}');
    }
  }

  Future<PerformanceStats> getD0StatsData() async {
    final response = await httpClient.get(performanceEndpoint);
    if (response.statusCode == 200) {
      _log.info("PerformanceStats API request successful");
      PerformanceStats feed = serializers.deserializeWith(
          PerformanceStats.serializer, json.decode(response.body));
      return feed;
    } else {
      throw Exception(
          'Failed to load the performance\n ${response.body} - ${response.statusCode}');
    }
  }

  Future<StockStats> getStockStatsData() async {
    final response = await httpClient.get(stocksEndpoint);
    if (response.statusCode == 200) {
      _log.info("StockStats API request successful");
      StockStats feed = serializers.deserializeWith(
          StockStats.serializer, json.decode(response.body));
      return feed;
    } else {
      throw Exception(
          'Failed to load the stocks\n ${response.body} - ${response.statusCode}');
    }
  }

  Future<NewsArticle> getArticleData({String articleId}) async {
    final response = await httpClient.get('$articleEndpoint$articleId');
    if (response.statusCode == 200) {
      _log.info("Article API request successful");
      NewsArticle article = serializers.deserializeWith(
          NewsArticle.serializer, json.decode(response.body));
      return article;
    } else {
      throw Exception(
          'Failed to load the stocks\n ${response.body} - ${response.statusCode}');
    }
  }
}
