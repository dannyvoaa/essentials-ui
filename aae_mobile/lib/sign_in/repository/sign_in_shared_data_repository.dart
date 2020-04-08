import 'package:aae/model/topics.dart';
import 'package:aae/model/workgroup.dart';
import 'package:aae/rx/rx_util.dart';
import 'package:aae/rxdart/rx.dart';
import 'package:inject/inject.dart';
import 'package:quiver/core.dart';

/// Shared value store for the Sign In workflow.
///
/// An instance of this class can be explicitly passed to BLoCs in
/// [SignInWorkflowBlocProvider] that need to pass data to other BLoCs. A good
/// example of this is passing the workgroups from [WorkgroupsSelectionBloc] and the
/// topics from [TopicsSelectionBloc] to the BLoC that creates the account.
@provide
class SignInSharedDataRepository {
  /// The selected workgroups.
  ///
  /// Set by: [WorkgroupsSelectionBloc].
  /// Consumed by: [ProfileCreationBloc] and [ModifyPreferenceBloc].
  final Subject<Optional<Workgroup>> workgroups =
      createBehaviorSubject(initial: Optional.absent());

  /// The selected Topics.
  ///
  /// Set by: [TopicsSelectionBloc].
  /// Consumed by: [ProfileCreationBloc] and [ModifyPreferenceBloc].
  final Subject<Optional<Topics>> topics =
      createBehaviorSubject(initial: Optional.absent());
}
