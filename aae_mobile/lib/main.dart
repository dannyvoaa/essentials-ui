import 'package:aae/build_flavor.dart';
import 'package:aae/programmatic_main.dart';

/// Entry point for the debug flavor of the app.
///
/// The meat of what would normally go in main() is in programmatic_main.dart.
/// Please make all changes in that file, unless your change is  something that
/// will only ever be needed in the debug flavor. Read the charter comment in
/// programmatic_main.dart for a discussion of where to make changes.
void main() async {
  programmaticMain(
    BuildFlavorConfiguration.configurationFor(
      BuildFlavor.debug,
    ),
  );
}
