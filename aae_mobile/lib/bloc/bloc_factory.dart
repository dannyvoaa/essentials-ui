import 'package:aae/article/news_article_bloc.dart';
import 'package:aae/d0_stats_bar/bloc/d0_stats_bar_bloc.dart';
import 'package:aae/events/component/calendar/calendar_bloc.dart';
import 'package:aae/events/component/events_list/events_list_bloc.dart';
import 'package:aae/home/news_feed_top_bar/top_bar_title_bloc.dart';
import 'package:aae/home/news_feed_list_item/news_feed_list_item_bloc.dart';
import 'package:aae/home/news_feed_list_collection/news_feed_list_collection_bloc.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/recognition/component/points_balance/points_balance_bloc.dart';
import 'package:aae/recognition/component/points_history/points_history_bloc.dart';
import 'package:aae/settings/settingslist/settings_list_bloc.dart';
import 'package:aae/sign_in/workflow/sign_in_state_machine.dart';
import 'package:aae/travel/component/priority_list/details/priority_list_bloc.dart';
import 'package:aae/travel/component/trips/trips_bloc.dart';

/// A factory that provides BLoC instances.
abstract class BlocFactory
    implements
        NewsFeedListItemBlocFactory,
        NewsFeedListCollectionBlocFactory,
        TopBarTitleBlocFactory,
        CalendarBlocFactory,
        SettingsListBlocFactory,
        SignInStateMachineFactory,
        PointsBalanceBlocFactory,
        PointsHistoryBlocFactory,
        TripsBlocFactory,
        PriorityListBlocFactory,
        EventsListBlocFactory,
        D0StatsBlocFactory,
        NewsArticleBlocFactory,
        ProvidedService {}
