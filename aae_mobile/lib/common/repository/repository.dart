import 'package:aae/logging/logging.dart';
import 'package:aae/provided_service.dart';

/// Common interface for repositories that store user data.
abstract class Repository extends ProvidedService {
  /// Starts any automatic actions the repository is responsible for, i.e.
  /// polling for data updates or responding to cache invalidations.
  void start();

  /// Stops all automatic actions.
  ///
  /// Stopped repositories should not poll or respond to cache invalidations.
  /// They should fetch data only in response to a specific request from a
  /// caller.
  void stop();

  /// Clears the repository's data.
  ///
  /// This function should only be called when the repository is stopped. If it
  /// is called, the repository should clear as much of its in-memory data as
  /// possible (i.e, data in behavior subjects). It should make sure that
  /// calling start() will trigger an immediate refresh of data.
  ///
  /// Be wary of any actions that will send null on a subject, as this may have
  /// unexpected consequences/result in NPEs. Same for reinstantiating a
  /// subject, since someone might be listening to the old one.
  void clear();

  /// Adds the appropriate prefix for repository log filtering
  ///
  /// Expects the name of the repository class as a string
  static String buildLogName(String name) {
    return "$repositoryLogPrefix.$name";
  }
}
