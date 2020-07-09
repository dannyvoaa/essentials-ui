import 'dart:collection';

import 'package:aae/model/hub_location.dart';
import 'package:aae/model/workgroup.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a list of workgroups.
class HubLocationsRepository {
  static final _log = Logger('HubLocationsRepository');

  UnmodifiableListView<HubLocation> _cachedHubLocationsList;

  @provide
  @singleton
  HubLocationsRepository();

  /// Gets the list of possible user workgroups.
  Future<UnmodifiableListView<HubLocation>> get hubLocationsList async => _cachedHubLocationsList ??= await _fetchHubLocationsList();

  Future<UnmodifiableListView<HubLocation>> _fetchHubLocationsList() async {
    List<HubLocation> listOfHubLocations = List<HubLocation>();
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'BOS'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'CLT'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'DCA'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'DFW'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'LAX'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'MIA'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'NYC'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'JFK'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'LGA'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'ORD'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'PHL'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'PHX'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'TUL'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'INTL'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'GSC'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'Central Region'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'Northeast Region'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'Southeast Region'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'West Region'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'Asia Pacific'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'Canada'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'Europe'));
    listOfHubLocations.add(HubLocation((b) => b.hubLocations = 'MCLA'));
    return UnmodifiableListView(listOfHubLocations);
  }
}
