import 'package:aae/model/article_body.dart';
import 'package:aae/model/biometric_auth.dart';
import 'package:aae/model/news_article.dart';
import 'package:aae/model/notification.dart';
import 'package:aae/model/performance_stats.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/model/stock_stats.dart';
import 'package:aae/model/topics.dart';
import 'package:aae/model/workgroup.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'docs.dart';
import 'event.dart';
import 'news_feed.dart';
import 'news_feed_item.dart';
import 'recognition_history.dart';
import 'recognition_register.dart';
import 'pnr_info.dart';
import 'trips.dart';


part 'serializers.g.dart';

@SerializersFor(const [
  NewsFeed,
  NewsFeedItem,
  RecognitionHistory,
  Trips,
  PnrInfo,
  Profile,
  Workgroup,
  Topics,
  Docs,
  Event,
  Notification,
  StockStats,
  PerformanceStats,
  NewsArticle,
  ArticleBody,
  BiometricAuth
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

T deserialize<T>(dynamic value) => standardSerializers.deserializeWith<T>(
    standardSerializers.serializerForType(T), value);

BuiltList<T> deserializeListOf<T>(dynamic value) => BuiltList.from(
    value.map((value) => deserialize<T>(value)).toList(growable: false));
