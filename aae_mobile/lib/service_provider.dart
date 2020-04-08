import 'package:logging/logging.dart';
import 'package:aae/provided_service.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends InheritedWidget {
  static final Logger log = Logger('ServiceProvider');

  final Map<Type, ProvidedService> _providedServices;
  final ServiceProvider _parent;

  /// Creates a ServiceProvider with the given [ProvidedService]s.
  ///
  /// [parent] specifies an optional parent [ServiceProvider] to look services
  /// up on if they cannot be found on this instance. The parent lookup is
  /// recursive.
  ServiceProvider({
    Iterable<ProvidedService> services = const <ProvidedService>[],
    Key key,
    Widget child,
    ServiceProvider parent,
  })  : _providedServices = _servicesByType(services),
        _parent = parent,
        super(key: key, child: child);

  @visibleForTesting
  void addServiceForTest<T extends ProvidedService>(T service) {
    if (_providedServices.containsKey(T)) {
      throw '$T is already configured. '
          'For tests construct a ServiceProvider with an empty list of services '
          'and specify mock services using '
          'addServiceForTest<MyRealServiceType>(myMockServiceInstance)';
    }
    _providedServices[T] = service;
  }

  static Map<Type, ProvidedService> _servicesByType(
          Iterable<ProvidedService> services) =>
      services.fold(
        <Type, ProvidedService>{},
        (Map<Type, ProvidedService> servicesByType, ProvidedService service) =>
            servicesByType..[service.runtimeType] = service,
      );

  /// Returns the nearest [ServiceProvider] in this [context].
  static ServiceProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(ServiceProvider);

  /// Returns the service of type [T] in this [BuildContext].
  static T serviceOf<T extends ProvidedService>(BuildContext context) =>
      _extract<T>(context);

  /// This is just a wrapper around service instances. The service instances
  /// themselves never change so this widget is immutable.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  /// A helper that extracts the [ServiceProvider] [InheritedWidget] from the
  /// provided [BuildContext] and returns a service of type [T] by invoking
  /// [provider].
  static T _extract<T extends ProvidedService>(BuildContext context) {
    var services = context.inheritFromWidgetOfExactType(ServiceProvider);

    // Sanity check that there is indeed a ServiceProvider in the build context
    // tree.
    assert(services is ServiceProvider,
        "Couldn't find the ServiceProvider for specified build context");

    // Sanity check that the service actually exists or is implemented by a
    // service on the ServiceProvider.
    var serviceProvider = services as ServiceProvider;
    final service = serviceProvider._extractService<T>();

    assert(service != null,
        "Couldn't find service of type $T on any ServiceProvider");

    // Found the service successfully.
    return service;
  }

  T _extractService<T extends ProvidedService>() {
    var service = _providedServices[T];
    if (service == null) {
      log.fine("Type $T not directly found in services");
      for (var value in _providedServices.values) {
        if (value is T) {
          log.fine("Type $T indirectly found as ${value.runtimeType}");
          return value;
        }
      }
      // If there is a parent, look up the service on the parent.
      return _parent?._extractService<T>();
    }

    return service;
  }
}
