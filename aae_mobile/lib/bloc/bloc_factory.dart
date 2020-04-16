import 'package:aae/article/bloc/article_bloc.dart';
import 'package:aae/d0_stats_bar/bloc/d0_stats_bar_bloc.dart';
import 'package:aae/events/component/calendar/calendar_bloc.dart';
import 'package:aae/events/component/events_list/events_list_bloc.dart';
import 'package:aae/home/component/news_feed_top_bar/top_bar_title_bloc.dart';
import 'package:aae/home/component/news_item/news_list_item_bloc.dart';
import 'package:aae/home/component/news_list/news_list_collection_bloc.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/recognition/component/points_balance/points_balance_bloc.dart';
import 'package:aae/recognition/component/points_history/points_history_bloc.dart';
import 'package:aae/settings/settingslist/settings_list_bloc.dart';
import 'package:aae/sign_in/workflow/sign_in_state_machine.dart';

/// A factory that provides BLoC instances.
abstract class BlocFactory
    implements
        NewsListItemBlocFactory,
        NewsListCollectionBlocFactory,
        TopBarTitleBlocFactory,
        CalendarBlocFactory,
        SettingsListBlocFactory,
        SignInStateMachineFactory,
        PointsBalanceBlocFactory,
        PointsHistoryBlocFactory,
        EventsListBlocFactory,
        D0StatsBlocFactory,
        NewsArticleBlocFactory,
        ProvidedService {}
