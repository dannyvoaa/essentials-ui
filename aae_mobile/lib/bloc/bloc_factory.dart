import 'package:aae/events/component/events_list/events_list_bloc.dart';
import 'package:aae/home/component/news_item/news_list_item_bloc.dart';
import 'package:aae/home/component/news_list/news_list_collection_bloc.dart';
import 'package:aae/home/component/news_list_row_collection/news_list_row_collection_bloc.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/recognition/component/points_balance/points_balance_bloc.dart';
import 'package:aae/recognition/component/points_history/points_history_bloc.dart';
import 'package:aae/settings/modify/bloc/modify_preference_bloc.dart';
import 'package:aae/settings/preferences/app_preferences_bloc.dart';
import 'package:aae/settings/settingsbuttonslist/settings_buttons_list_bloc.dart';
import 'package:aae/settings/workflow/modifying/modify_state_machine.dart';
import 'package:aae/sign_in/workflow/sign_in_state_machine.dart';

/// A factory that provides BLoC instances.
abstract class BlocFactory
    implements
        NewsListItemBlocFactory,
        NewsListCollectionBlocFactory,
        NewsListRowCollectionBlocFactory,
        SettingsButtonsListBlocFactory,
        AppPreferencesBlocFactory,
        SignInStateMachineFactory,
        PointsBalanceBlocFactory,
        PointsHistoryBlocFactory,
        EventsListBlocFactory,
        ModifyStateMachineFactory,
        ModifyPreferenceBlocFactory,
        ProvidedService {}
