/// An interface to be invoked when application lifecycle events are triggered.
abstract class LifecycleManagedService {
  /// Called when the application is entering the foreground.
  void onResume();

  /// Called when the application is in an inactive state and is not receiving
  /// user input.
  void onInactive();

  /// Called when the application is entering the background or shutting down.
  void onPause();
}
