import 'package:aae/provided_service.dart';
import 'package:aae/service_provider.dart';
import 'package:flutter/material.dart';

/// Creates a BLoC of type [B] from the given [ProvidedService] [factory] of
/// type [F].
typedef B ComponentBlocFactory<B, F extends ProvidedService>(F factory);

/// Builds a [Component]'s [Widget] representation from its associated [bloc]
/// instance.
typedef Widget ComponentBuilder<B>(BuildContext context, B bloc);

/// A builder that produces a [Component] with a backing BLoC instance of type
/// [B] using a factory of type [F].
///
/// A [Component] is a standalone piece of UI with an associated BLoC instance.
/// The [Component]'s BLoC will remain the same instance for the lifetime of
/// the [Component]'s parent.
class Component<B, F extends ProvidedService> extends StatefulWidget {
  final ComponentBlocFactory<B, F> bloc;
  final ComponentBuilder<B> builder;

  Component({
    @required this.bloc,
    @required this.builder,
  });

  @override
  State<Component<B, F>> createState() => _ComponentState<B, F>();
}

/// [State] for a corresponding [Component].
///
/// This [State] serves as a mechanism to create a single BLoC instance and
/// keep it associated with the same [Component] instance. This allows us to
/// have multiple [Component] instances on the same page, across the entire app,
/// etc... each of which with their own local BLoC state.
class _ComponentState<B, F extends ProvidedService>
    extends State<Component<B, F>>
    with AutomaticKeepAliveClientMixin<Component<B, F>> {
  B bloc;

  @override
  void didChangeDependencies() {
    // Called once after State creation and once the BuildContext is ready to
    // use. Creates the BLoC so that it can be passed into the component's
    // builder.
    super.didChangeDependencies();
    bloc ??= widget.bloc(ServiceProvider.serviceOf<F>(context));
  }

  @override
  Widget build(BuildContext context) {
    // We must call super.build(context) and ignore the return value according
    // to the AutomaticKeepAliveClientMixin docs.
    super.build(context);

    // Return the component's builder using its corresponding BLoC instance.
    return widget.builder(context, bloc);
  }

  @override
  bool get wantKeepAlive {
    // This lets the component's state continue to live even if the component
    // has been scrolled passed a containing list's cache extents. This is
    // important, because if its not here the state will be disposed of and
    // recreated when the list element comes back into view, which causes a
    // new BLoC instance to be created.
    return true;
  }
}
