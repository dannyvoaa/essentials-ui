import 'package:aae/model/airport.dart';
import 'package:aae/model/airports_wrapper.dart';
import 'package:aae/model/article_body.dart';
import 'package:aae/model/biometric_auth.dart';
import 'package:aae/model/check_in_passenger.dart';
import 'package:aae/model/check_in_request.dart';
import 'package:aae/model/docs.dart';
import 'package:aae/model/dzerodocs.dart';
import 'package:aae/model/event.dart';
import 'package:aae/model/gate_time_flight_info.dart';
import 'package:aae/model/hub_location.dart';
import 'package:aae/model/news_article.dart';
import 'package:aae/model/news_articledocs.dart';
import 'package:aae/model/news_feed_item.dart';
import 'package:aae/model/news_feed_json_list.dart';
import 'package:aae/model/nfdocs.dart';
import 'package:aae/model/notification.dart';
import 'package:aae/model/performance_stats.dart';
import 'package:aae/model/pnr.dart';
import 'package:aae/model/priority_list.dart';
import 'package:aae/model/priority_list_cabin.dart';
import 'package:aae/model/priority_list_passenger.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/model/recognition_history.dart';
import 'package:aae/model/recognition_register.dart';
import 'package:aae/model/reservation_detail.dart';
import 'package:aae/model/reservation_detail_passenger.dart';
import 'package:aae/model/reservation_detail_seat_assignment.dart';
import 'package:aae/model/reservation_detail_segment.dart';
import 'package:aae/model/reservation_detail_passenger_info.dart';
import 'package:aae/model/stock_stats.dart';
import 'package:aae/model/stockdocs.dart';
import 'package:aae/model/topics.dart';
import 'package:aae/model/trips.dart';
import 'package:aae/model/workgroup.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'boarding_pass.dart';
import 'boarding_pass_wrapper.dart';
import 'countries.dart';
import 'flight_search.dart';
import 'flight_status.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Airport,
  AirportsWrapper,
  BoardingPass,
  BoardingPassWrapper,
  Country,
  CountriesWrapper,
  NewsFeedJsonList,
  NewsFeedItem,
  RecognitionHistory,
  Trips,
  Pnr,
  PriorityList,
  PriorityListCabin,
  PriorityListPassenger,
  ReservationDetail,
  ReservationDetailPassenger,
  ReservationDetailSegment,
  ReservationDetailSeatAssignment,
  ReservationDetailPassengerInfo,
  CheckInRequest,
  CheckInPassenger,
  FlightStatus,
  GateTimeFlightInfo,
  FlightSearch,
  Profile,
  Workgroup,
  HubLocation,
  Topics,
  Docs,
  Event,
  Notification,
  StockStats,
  Stockdocs,
  PerformanceStats,
  Dzerodocs,
  NewsArticle,
  Newsarticledocs,
  ArticleBody,
  BiometricAuth,
  Nfdocs
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
