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

  @provide
  SettingsListBloc(this._profileRepository);

  Source<SettingsListViewModel> get viewModel => toSource(
        combineLatest(_profileRepository.profile, _createViewModel),
      );

  SettingsListViewModel _createViewModel(Profile profile) =>
      SettingsListViewModel(
          displayName: profile.displayName,
          location: profile.location,
          topics: [
            'Headlines',
            'Business-Education',
            'Fleet',
            'Network',
            'Operations',
            'People-Culture',
            'Products-Services'
          ],
          selectedTopics: profile.topics,
          workgroup: [
            'ACS (Airport Customer Service)',
            'Cargo',
            'Fleet Service',
            'Flight (Pilots)',
            'Flight Service  (Flight Attendants)',
            'LSS (Leadership & Support Staff)',
            'PGS  (Premium Guest Services)',
            'Reservations',
            'Tech Ops'
          ],
          selectedWorkgroups: profile.workgroup,
          onTopicTapped: _onTopicTapped,
          onWorkgroupTapped: _onWorkgroupTapped);

  void _onTopicTapped(String tappedTopic) async {
    Profile currentProfile = await _profileRepository.fetchActiveProfile();
    if (currentProfile.topics.contains(tappedTopic)) {
      Profile updatedProfile = currentProfile.rebuild(
          (b) => b.topics.removeWhere((topic) => topic == tappedTopic));
      _profileRepository.updateProfile(updatedProfile);
      print(updatedProfile);
    } else {
      Profile updatedProfile =
          currentProfile.rebuild((b) => b.topics.add(tappedTopic));
      print(updatedProfile);
      _profileRepository.updateProfile(updatedProfile);
    }
  }

  void _onWorkgroupTapped(String tappedWorkgroup) async {
    Profile currentProfile = await _profileRepository.fetchActiveProfile();
    if (currentProfile.workgroup.contains(tappedWorkgroup)) {
      Profile updatedProfile = currentProfile.rebuild((b) =>
          b.workgroup.removeWhere((workgroup) => workgroup == tappedWorkgroup));
      _profileRepository.updateProfile(updatedProfile);
      print(updatedProfile);
    } else {
      Profile updatedProfile =
          currentProfile.rebuild((b) => b.workgroup.add(tappedWorkgroup));
      print(updatedProfile);
      _profileRepository.updateProfile(updatedProfile);
    }
  }
}

/// Constructs new instances of [SettingsListBloc]s via the DI framework.
abstract class SettingsListBlocFactory implements ProvidedService {
  @provide
  SettingsListBloc settingsListBloc();
}
