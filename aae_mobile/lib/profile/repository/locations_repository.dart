import 'dart:collection';

import 'package:aae/model/hub_location.dart';
import 'package:aae/model/workgroup.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a list of locations.
class HubLocationsRepository {
  static final _log = Logger('HubLocationsRepository');

  UnmodifiableListView<HubLocation> _cachedHubLocationsList;

  @provide
  @singleton
  HubLocationsRepository();

  /// Gets the list of possible user locations.
  Future<UnmodifiableListView<HubLocation>> get hubLocationsList async => _cachedHubLocationsList ??= await _fetchHubLocationsList();

  Future<UnmodifiableListView<HubLocation>> _fetchHubLocationsList() async {
    List<HubLocation> listOfHubLocations = List<HubLocation>();
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'CLT'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'DCA'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'DFW'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'LAX'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'MIA'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'NYC'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'ORD'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'PHL'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'PHX'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'TUL'));
    return UnmodifiableListView(listOfHubLocations);
  }
}