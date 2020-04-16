import 'package:aae/auth/sso_identity.dart';
import 'package:aae/provided_service.dart';
import 'package:aae/rx/bloc_with_rx.dart';
import 'package:aae/rx/combine_latest.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:aae/sign_in/repository/sign_in_repository.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

import 'top_bar_title_view_model.dart';

/// BloC for the [TopBarTitleComponent].
///
/// Exposes a [TopBarTitleViewModel] for that component to use.

class TopBarTitleBloc {
  static final _log = Logger('PointsHistoryBloc');
  final SignInRepository _signInRepository;

  Source<TopBarTitleViewModel> get viewModel => toSource(combineLatest(
      Observable.fromFuture(_signInRepository.identity), _createViewModel));

  @provide
  TopBarTitleBloc(this._signInRepository);

  TopBarTitleViewModel _createViewModel(SSOIdentity identity) =>
      TopBarTitleViewModel(displayName: identity.displayName);
}

/// Constructs new instances of [TopBarTitleBloc]s via the DI framework.
abstract class TopBarTitleBlocFactory implements ProvidedService {
  @provide
  TopBarTitleBloc topBarTitleBloc();
}
