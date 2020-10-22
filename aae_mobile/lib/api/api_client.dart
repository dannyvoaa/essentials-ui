import 'dart:convert';
import 'dart:io';

import 'package:aae/model/docs.dart';
import 'package:aae/model/event.dart';
import 'package:aae/model/news_article.dart';
import 'package:aae/model/news_feed_json_list.dart';
import 'package:aae/model/nfdocs.dart';
import 'package:aae/model/performance_stats.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/model/profile_query.dart';
import 'package:aae/model/serializers.dart';
import 'package:aae/model/stock_stats.dart';
import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

///
/// All Api calls in one class.
///
class NewsServiceApi {
  static final Logger _log = Logger('AAE NewsFeed API Client');
  final http.Client httpClient = http.Client();
  static String strCloudantAuth = 'https://toreetherywhimandifersee:55608bd3e3255fe1851de225ce562d4cab7d8fa2';
  static String strCloudantDomain = strCloudantAuth + '@b23661f9-9acc-4aab-9a2b-f8aa0f41b993-bluemix.cloudantnosqldb.appdomain.cloud';
  static String strSFDomain = 'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev';

  final baseUrl = strSFDomain + '/default/ae-newsfeed.json?tag=';
  final preferencesEndpoint = strCloudantDomain + '/user_preferences/_find';
  final newsfeedEndpoint = 'https://toreetherywhimandifersee:55608bd3e3255fe1851de225ce562d4cab7d8fa2@b23661f9-9acc-4aab-9a2b-f8aa0f41b993-bluemix.cloudantnosqldb.appdomain.cloud/news_feeds/_find';
  //final preferencesEndpoint = 'https://us-south.functions.cloud.ibm.com/api/v1/web/AA-CorpTech-Essentials_dev/user-profile/aeuserpreffromdb.json';
  final eventsEndpoint = 'https://beredididleatecturingele:457299efd6f5f57dbd679a0362d377a1ccf5018a@b23661f9-9acc-4aab-9a2b-f8aa0f41b993-bluemix.cloudantnosqldb.appdomain.cloud/events/_find';
  final stocksEndpoint = strSFDomain + '/default/AALStock.json';
  final performanceEndpoint = strSFDomain + '/default/PerformanceStats.json';
  final articleEndpoint = strSFDomain + '/default/ae-newsarticle.json?contentID=';

  Future<List<NewsFeedJsonList>> getNewsFeed(List<String> tags) async {
    final headers = {'content-type': 'application/json'};

    List<NewsFeedJsonList> myFeedJsonList = <NewsFeedJsonList>[];
    for (var tag in tags) {
      var tag2 = '';
      if (tag.trim().contains(' ', 0))
        tag2 = tag.replaceAll(' ', '-') + "";
      else
        tag2 = tag + "";
      var body = jsonEncode({
        "selector": {
          "_id": {"\$eq": tag2}
        },
        "fields": ["list"]
      });

      final response = await httpClient.post(newsfeedEndpoint, headers: headers, body: body).then((http.Response r) => r);
      if (response.statusCode == 200) {
        Nfdocs query = serializers.deserializeWith(Nfdocs.serializer, json.decode(response.body));
        _log.info("Newsfeed API request successful");
        BuiltList<NewsFeedJsonList> myBL = query.nfjl;
        myFeedJsonList.addAll(myBL);
      } else {
        throw Exception('Failed to load the news feed\n ${response.body} - ${response.statusCode} - $tag');
      }

      //sleep(Duration(milliseconds:500));
      //await Future.delayed(Duration(seconds: 2));
    }
    return myFeedJsonList;
  }

  Future<List<NewsFeedJsonList>> getNewsFeed2(List<String> tags) async {
    List<NewsFeedJsonList> myFeedJsonList = <NewsFeedJsonList>[];
    for (var tag in tags) {
      final response = await httpClient.get('$baseUrl$tag&count=5&page=0').then((http.Response r) => r);
      if (response.statusCode == 200) {
        //_log.info("Newsfeed API request successful");
        NewsFeedJsonList myFeedJsonListResponse = serializers.deserializeWith(NewsFeedJsonList.serializer, json.decode(response.body));
        myFeedJsonList.add(myFeedJsonListResponse);
      } else {
        throw Exception('Failed to load the news feed\n ${response.body} - ${response.statusCode} - $tag');
      }
    }
    return myFeedJsonList;
  }

  Future<Profile> getProfile(String aaId) async {
    final headers = {'content-type': 'application/json'};
    final body = jsonEncode({
      "selector": {
        "_id": {"\$eq": aaId}
      },
      "fields": ["preferences"],
      "sort": [
        {"_id": "asc"}
      ]
    });

    final response = await httpClient
        .post(preferencesEndpoint, headers: headers, body: body)
        .then((http.Response r) => r);
    if (response.statusCode == 200) {
      ProfileQuery profileQuery = ProfileQuery.fromJson(jsonDecode(response.body));
      Profile profile = Profile((b) => b
        ..userlocation = profileQuery.docs[0].preferences.userlocation
        ..workgroup.addAll(profileQuery.docs[0].preferences.workgroup)
        ..hubLocation.addAll(profileQuery.docs[0].preferences.hubLocation)
        ..topics.addAll(profileQuery.docs[0].preferences.topics));

      //print(profile);

      _log.info("Profile request successful");
      return profile;
    } else {
      throw Exception(
          'Failed on profile request \n ${response.body} - ${response.statusCode}');
    }
  }

  Future<Profile> getProfile2(String aaId) async {
    final headers = {'content-type': 'application/json'};
    final response = await httpClient.get(preferencesEndpoint + "?aaId=" + aaId, headers: headers).then((http.Response r) => r);

    if (response.statusCode == 200) {
      ProfileQuery profileQuery = ProfileQuery.fromJson(jsonDecode(response.body));

      Profile profile = Profile(
              (b) {
            b.userlocation = profileQuery.docs[0].preferences.userlocation;
            b.hubLocation.addAll(profileQuery.docs[0].preferences.hubLocation);
            b.workgroup.addAll(profileQuery.docs[0].preferences.workgroup);
            b.topics.addAll(profileQuery.docs[0].preferences.topics);
            return b;
          }
      );

      //print(profile);
      //_log.info("Profile request successful");
      return profile;
    } else {
      throw Exception('Failed on profile request \n ${response.body} - ${response.statusCode}');
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

      //_log.info("Events request successful");
      //_log.shout('dataQuery: $query');
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
      Docs query = serializers.deserializeWith(Docs.serializer, json.decode(response.body));
      //_log.info("Events request successful");
      return query.events.toList();
    } else {
      throw Exception(
          'Failed on events request \n ${response.body} - ${response.statusCode}');
    }
  }

  Future<PerformanceStats> getD0StatsData() async {
    final response = await httpClient.get(performanceEndpoint);
    if (response.statusCode == 200) {
      //_log.info("PerformanceStats API request successful");
      PerformanceStats feed = serializers.deserializeWith(PerformanceStats.serializer, json.decode(response.body));
      return feed;
    } else {
      throw Exception(
          'Failed to load the performance\n ${response.body} - ${response.statusCode}');
    }
  }

  Future<StockStats> getStockStatsData() async {
    final response = await httpClient.get(stocksEndpoint);
    if (response.statusCode == 200) {
      //_log.info("StockStats API request successful");
      StockStats feed = serializers.deserializeWith(StockStats.serializer, json.decode(response.body));
      return feed;
    } else {
      throw Exception(
          'Failed to load the stocks\n ${response.body} - ${response.statusCode}');
    }
  }

  Future<NewsArticle> getArticleData({String articleId}) async {
    final response = await httpClient.get('$articleEndpoint$articleId');
    if (response.statusCode == 200) {
      //_log.info("Articles API request successful");
      NewsArticle article = serializers.deserializeWith(NewsArticle.serializer, json.decode(response.body));
      return article;
    } else {
      throw Exception('Failed to load the stocks\n ${response.body} - ${response.statusCode}');
    }
  }
}
