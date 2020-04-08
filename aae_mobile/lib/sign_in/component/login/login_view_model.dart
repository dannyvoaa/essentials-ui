import 'package:aae/common/commands/aae_command.dart';
import 'package:built_value/built_value.dart';

part 'login_view_model.g.dart';

/// View model representing a [LoginView].
abstract class LoginViewModel
    implements Built<LoginViewModel, LoginViewModelBuilder> {
  String get primaryButtonText;

  AaeCommand get onPrimaryButtonPressed;

  LoginViewModel._();

  factory LoginViewModel([updates(LoginViewModelBuilder b)]) = _$LoginViewModel;
}
