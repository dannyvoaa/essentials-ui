import 'package:aae/api/hsm_state_machine.dart';
import 'package:quiver/core.dart';
import 'package:meta/meta.dart';

const _routeSeparator = '/';
const _noSeparator = '';

/// A state to be used in a [Workflow].
class WorkflowState {
  /// The name of this state.
  final String name;

  /// The children of this state.
  Set<WorkflowState> get children => Set.of(_children);
  final Set<WorkflowState> _children;

  /// The initial child of this state, if defined.
  ///
  /// If given, the initial child must be in [children].
  final Optional<WorkflowState> initial;

  /// The route segment associated with this state.
  ///
  /// If absent, no navigation segment will be included for this state when
  /// navigation routes are calculated.
  ///
  /// Note that whether or not this is present does not affect whether this
  /// state should be navigated to when entered. That is controlled solely by
  /// the [navigateOnTransition] parameter. This state could be an intermediary
  /// state that doesn't define any route information but should still navigate
  /// to the route defined by its initial child when it is entered. Or it could
  /// be a root state that shouldn't trigger navigation when entered but should
  /// pass down a route segment to all of its children.
  final Optional<String> routeSegment;

  /// Whether the default behavior for transitioning to this state includes
  /// navigating to a page.
  ///
  /// If false, navigationRoute will always return absent, indicating that there
  /// is no route for this state. If true, navigationRoute will return a route
  /// if it finds any route segments for this state, its ancestors, or its
  /// descendants.
  final bool _navigateOnTransition;

  /// Computes the full navigate route of this state, if it has one.
  ///
  /// Concatenates all route segments from the direct ancestors of this state,
  /// this state, and its direct descendants, following the line of initial
  /// states down to the leaf.
  Optional<String> navigationRoute(Machine<WorkflowState, Object> machine) {
    if (!_navigateOnTransition) return Optional.absent();

    final parent = _parentPath(machine);
    final current = routeSegment.or('');
    final child = _childPath();

    final fullRoute = _joinRouteParts(_joinRouteParts(parent, current), child);

    // This shouldn't be empty, because there should be a route in some part of
    // the state's path if navigateOnEnter is true. But check just in case.
    return fullRoute.isEmpty ? Optional.absent() : Optional.of(fullRoute);
  }

  /// Recursively walks the state machine towards root, concatenating all path
  /// segments from parents.
  ///
  /// Runs in O(h) where h is the height of the state tree.
  String _parentPath(Machine<WorkflowState, Object> hsm) {
    final parent = hsm[this].parent?.id;

    if (parent != null) {
      final priorSegments = parent._parentPath(hsm);
      final parentSegment = parent.routeSegment.or('');

      return _joinRouteParts(priorSegments, parentSegment);
    }

    return '';
  }

  /// Recursively walks the state machine towards leaves, following the line of
  /// initial children, and concatenates path segments from descendants.
  ///
  /// Runs in O(h) where h is the height of the state tree.
  String _childPath() {
    final initialState = initial.orNull;

    if (initialState != null) {
      final childSegment = initialState.routeSegment.or('');
      final descendantSegments = initialState._childPath();

      return _joinRouteParts(childSegment, descendantSegments);
    }

    return '';
  }

  static String _joinRouteParts(String first, String second) {
    final separator =
        first.isNotEmpty && second.isNotEmpty ? _routeSeparator : _noSeparator;

    return [first, second].join(separator);
  }

  /// Creates a WorkflowState.
  ///
  /// [navigateOnTransition] defines whether this is a state that by default
  /// should trigger a page navigation when entered.
  WorkflowState({
    @required this.name,
    Set<WorkflowState> children,
    WorkflowState initial,
    String routeSegment,
    bool navigateOnTransition = false,
  })  : _children = children ?? {},
        _navigateOnTransition = navigateOnTransition,
        initial = Optional.fromNullable(initial),
        routeSegment = Optional.fromNullable(routeSegment) {
    if (initial != null && !_children.contains(initial)) {
      throw ArgumentError('Initial child must be in list of children.');
    }

    // It will break the navigation algorithm if a state has children and is
    // supposed to navigate on transition but does not have an initial state.
    // This case is explicitly disallowed.
    if (navigateOnTransition && _children.isNotEmpty && initial == null) {
      throw ArgumentError(
          'Navigable non-leaf states must define an initial state.');
    }
  }

  /// Defines two states to be equal if they share the same name.
  @override
  bool operator ==(o) => o is WorkflowState && o.name == name;

  /// Defines the states's hash code to be the hash code of its name.
  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    final data = {
      'name': name,
    };
    return 'WorkflowState $data';
  }
}
