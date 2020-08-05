import 'dart:collection';

import 'package:aae/home/news_feed_repository.dart';
import 'package:aae/model/news_feed_json_list.dart';
import 'package:aae/model/profile.dart';
import 'package:aae/profile/repository/profile_repository.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:inject/inject.dart';

import 'settings_list_view_model.dart';

/// BLoC for the [SettingsButtonsListComponent].
///
/// Exposes a [SettingsListViewModel] for that component to use.
class SettingsListBloc {
  ProfileRepository _profileRepository;
  NewsFeedRepository _newsFeedRepository;

  @provide
  SettingsListBloc(this._profileRepository, this._newsFeedRepository);

  Source<SettingsListViewModel> get viewModel => toSource(combineLatest(_profileRepository.profile, _createViewModel));

  SettingsListViewModel _createViewModel(Profile profile) =>
      SettingsListViewModel(
          displayName: profile.displayName,
          userlocation: profile.userlocation,
          topics: ['Headlines', 'Business Education', 'Fleet', 'Network', 'Operations', 'People Culture', 'Products Services'],
          selectedTopics: profile.topics,
          hubLocation: ['BOS', 'CLT', 'DCA', 'DFW', 'LAX', 'MIA', 'NYC', 'JFK', 'LGA', 'ORD', 'PHL', 'PHX', 'TUL', 'INTL', 'GSC', 'Central Region', 'Northeast Region', 'Southeast Region', 'West Region', 'Asia Pacific', 'Canada', 'Europe', 'MCLA'],
          selectedHubLocations: profile.hubLocation,
          workgroup: ['Airport Customer Service', 'Cargo', 'Fleet Service', 'Flight', 'Flight Service', 'Leadership and Support Staff', 'Premium Guest Services', 'Reservations', 'Tech Ops'],
          selectedWorkgroups: profile.workgroup,
          onTopicTapped: _onTopicTapped,
          onHubLocationTapped: _onHubLocationTapped,
          onWorkgroupTapped: _onWorkgroupTapped);

  void _onTopicTapped(String tappedTopic) async {
    Profile currentProfile = await _profileRepository.fetchActiveProfile();
    if (currentProfile.topics.contains(tappedTopic)) {
      Profile updatedProfile = currentProfile.rebuild((b) => b.topics.removeWhere((topic) => topic == tappedTopic));
      _profileRepository.updateProfile(updatedProfile);
      _newsFeedRepository.fetchNewsFeedJsonList(updatedProfile);
      //print(updatedProfile);
    } else {
      Profile updatedProfile = currentProfile.rebuild((b) => b.topics.add(tappedTopic));
      //print(updatedProfile);
      _profileRepository.updateProfile(updatedProfile);
      _newsFeedRepository.fetchNewsFeedJsonList(updatedProfile);
    }
  }

  void _onHubLocationTapped(String tappedHubLocation) async {
    Profile currentProfile = await _profileRepository.fetchActiveProfile();
    if (currentProfile.hubLocation.contains(tappedHubLocation)) {
      Profile updatedProfile = currentProfile.rebuild((b) => b.hubLocation.removeWhere((hubLocation) => hubLocation == tappedHubLocation));
      _profileRepository.updateProfile(updatedProfile);
      _newsFeedRepository.fetchNewsFeedJsonList(updatedProfile);
      //print(updatedProfile);
    } else {
      Profile updatedProfile =
      currentProfile.rebuild((b) => b.hubLocation.add(tappedHubLocation));
      //print(updatedProfile);
      _profileRepository.updateProfile(updatedProfile);
      _newsFeedRepository.fetchNewsFeedJsonList(updatedProfile);
    }
  }
  void _onWorkgroupTapped(String tappedWorkgroup) async {
    Profile currentProfile = await _profileRepository.fetchActiveProfile();
    if (currentProfile.workgroup.contains(tappedWorkgroup)) {
      Profile updatedProfile = currentProfile.rebuild((b) => b.workgroup.removeWhere((workgroup) => workgroup == tappedWorkgroup));
      _profileRepository.updateProfile(updatedProfile);
      _newsFeedRepository.fetchNewsFeedJsonList(updatedProfile);
      //print(updatedProfile);
    } else {
      Profile updatedProfile = currentProfile.rebuild((b) => b.workgroup.add(tappedWorkgroup));
      //print(updatedProfile);
      _profileRepository.updateProfile(updatedProfile);
      _newsFeedRepository.fetchNewsFeedJsonList(updatedProfile);
    }
  }
}

/// Constructs new instances of [SettingsListBloc]s via the DI framework.
abstract class SettingsListBlocFactory implements ProvidedService {
  @provide
  SettingsListBloc settingsListBloc();
}
