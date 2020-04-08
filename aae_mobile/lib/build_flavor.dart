import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart';

part 'build_flavor.g.dart';

/// Enumerates the possible Aae build flavors.
///
/// Debug points to more unstable services, has the most diagnostic options
/// turned on, and is the flavor that you, dear reader, will probably be
/// building locally the most.
class BuildFlavor extends EnumClass {
  static const BuildFlavor debug = _$debug;
  static const BuildFlavor preprod = _$preprod;
  static const BuildFlavor production = _$production;

  const BuildFlavor._(String name) : super(name);

  static BuiltSet<BuildFlavor> get values => _$values;

  static BuildFlavor valueOf(String name) => _$valueOf(name);
}

/// Defines the constants that are determined by build flavor.
class BuildFlavorConfiguration {
  /// The build flavor associated with this configuration.
  final BuildFlavor buildFlavor;

  /// Human-readable description of the flavor.
  final String name;

  /// Whether to show the debug banner, and to enable debug diagnostics.
  final bool useDebugMode;

  /// Whether to report errors/crashes externally. When set to false errors are
  /// reported locally only.
  final bool exportErrors;

  BuildFlavorConfiguration({
    @required this.buildFlavor,
    @required this.name,
    @required this.useDebugMode,
    @required this.exportErrors,
  });

  // Flavor you'll usually build at your desk
  static final _debugConfiguration = BuildFlavorConfiguration(
    buildFlavor: BuildFlavor.debug,
    name: 'Build Flavor',
    useDebugMode: true,
    exportErrors: false,
  );

  static final _preprodConfiguration = BuildFlavorConfiguration(
    buildFlavor: BuildFlavor.preprod,
    name: 'Pre-Production',
    useDebugMode: false,
    exportErrors: true,
  );

  static final _productionConfiguration = BuildFlavorConfiguration(
    buildFlavor: BuildFlavor.production,
    name: 'Production',
    useDebugMode: false,
    exportErrors: true,
  );

  factory BuildFlavorConfiguration.configurationFor(BuildFlavor flavor) {
    switch (flavor) {
      case BuildFlavor.debug:
        return _debugConfiguration;
      case BuildFlavor.preprod:
        return _preprodConfiguration;
      case BuildFlavor.production:
        return _productionConfiguration;
    }
    return _debugConfiguration;
  }
}
