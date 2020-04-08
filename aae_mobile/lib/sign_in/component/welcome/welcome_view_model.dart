import 'package:aae/common/commands/aae_command.dart';
import 'package:built_value/built_value.dart';

part 'welcome_view_model.g.dart';

/// View model representing a [WelcomeView].
abstract class WelcomeViewModel
    implements Built<WelcomeViewModel, WelcomeViewModelBuilder> {
  String get primaryButtonText;

  AaeCommand get onPrimaryButtonPressed;

  WelcomeViewModel._();
  factory WelcomeViewModel([updates(WelcomeViewModelBuilder b)]) =
      _$WelcomeViewModel;
}
