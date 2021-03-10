import 'dart:collection';

import 'package:aae/model/workgroup.dart';
import 'package:inject/inject.dart';
import 'package:logging/logging.dart';

/// A repository that stores a list of workgroups.
class WorkgroupsRepository {
  static final _log = Logger('WorkgroupsRepository');

  UnmodifiableListView<Workgroup> _cachedWorkgroupsList;

  @provide
  @singleton
  WorkgroupsRepository();

  /// Gets the list of possible user workgroups.
  Future<UnmodifiableListView<Workgroup>> get workgroupsList async =>
      _cachedWorkgroupsList ??= await _fetchWorkgroupsList();

  Future<UnmodifiableListView<Workgroup>> _fetchWorkgroupsList() async {
    List<Workgroup> listOfWorkgroups = List<Workgroup>();
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Airport Customer Service'));
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Cargo'));
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Fleet Service'));
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Flight'));
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Flight Service'));
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Leadership & Support Staff'));
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Premium Guest Services'));
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Reservations'));
    listOfWorkgroups.add(Workgroup((b) => b.workgroups = 'Tech Ops'));
    return UnmodifiableListView(listOfWorkgroups);
  }
}
