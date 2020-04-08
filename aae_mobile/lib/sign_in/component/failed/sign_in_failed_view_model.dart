import 'package:built_value/built_value.dart';
import 'package:aae/common/commands/aae_command.dart';

part 'sign_in_failed_view_model.g.dart';

/// View model representing a [SignInFailedView].
abstract class SignInFailedViewModel
    implements Built<SignInFailedViewModel, SignInFailedViewModelBuilder> {
  String get primaryButtonText;

  AaeCommand get onPrimaryButtonPressed;

  SignInFailedViewModel._();
  factory SignInFailedViewModel([updates(SignInFailedViewModelBuilder b)]) =
      _$SignInFailedViewModel;
}
