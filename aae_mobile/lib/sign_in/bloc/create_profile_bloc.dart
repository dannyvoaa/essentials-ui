import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:aae/sign_in/workflow/constants/sign_in_events.dart';
import 'package:aae/workflow/common/workflow_event.dart';
import 'package:logging/logging.dart';
import 'package:inject/inject.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/profile/repository/profile_repository.dart';

class CreateProfileBloc {
  static final _log = Logger('CreateProfileBloc');

  final ProfileRepository _profileRepository;
  final SignInSharedDataRepository _sharedDataRepository;

  final _events = Subject<WorkflowEvent>();

  /// Publishes events to be consumed by the [SignInStateMachine].
  Observable<WorkflowEvent> get events => _events;

  @provide
  @singleton
  CreateProfileBloc(this._profileRepository, this._sharedDataRepository);

  /// Attempts to create a profile using the current Workgroups and Topics.
  Future<void> createProfile() async {
    final topics = lastEvent(_sharedDataRepository.topics);
    final workgroups = lastEvent(_sharedDataRepository.workgroups);

    if (topics.isNotPresent || workgroups.isNotPresent) {
      _log.severe('Workgroups or Topics not set before creating a profile.');
      _events.sendNext(SignInEvents.profileCreationFailed);
      return;
    }

    if (await _profileRepository.createProfile(
        topics.value, workgroups.value)) {
      _events.sendNext(SignInEvents.profileCreationSucceeded);
    } else {
      _events.sendNext(SignInEvents.profileCreationFailed);
    }
  }
}

abstract class CreateProfileBlocFactory implements ProvidedService {
  @provide
  CreateProfileBloc createProfileBloc();
}
