//import 'dart:collection';
//
//import 'package:aae/events/repository/events_repository.dart';
//import 'package:aae/provided_service.dart';
//import 'package:aae/rx/bloc_with_rx.dart';
//import 'package:aae/rx/combine_latest.dart';
//import 'package:aae/rx/rx_util.dart';
//import 'package:inject/inject.dart';
//
//import 'calendar_view_model.dart';
//
///// BloC for the [CalendarComponent].
/////
///// Exposes a [CalendarViewModel] for that component to use.
//class CalendarBloc {
//  final EventsRepository _eventsRepository;
//
//  Source<CalendarViewModel> get viewModel =>
//      toSource(combineLatest(_eventsRepository., _createViewModel));
//
//  @provide
//  CalendarBloc(this._eventsRepository);
//
//  CalendarViewModel _createViewModel(
//      UnmodifiableListView<NewsFeedItem> newsFeedItem) {
//    return CalendarViewModel((b) => b
//      ..newsFeedItemIds.addAll(listOfNewsFeedItemIds(newsFeedItem))
//      ..newsFeedCategories.addAll(listOfNewsFeedCategories(newsFeedItem)));
//  }
//
//  List<String> listOfNewsFeedItemIds(
//      UnmodifiableListView<NewsFeedItem> newsFeedItems) =>
//      newsFeedItems
//          .map((newsFeedItem) => (newsFeedItem.id).toString())
//          .toList();
//
//  List<String> listOfNewsFeedCategories(
//      UnmodifiableListView<NewsFeedItem> newsFeedItems) =>
//      newsFeedItems.map((newsFeedItem) => (newsFeedItem.category)).toList();
//}
//
///// Constructs new instances of [NewsListCollectionBloc]s via the DI framework.
//abstract class CalendarBlocFactory implements ProvidedService {
//  @provide
//  CalendarBloc eventsBloc();
//}
