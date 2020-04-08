import 'package:aae/sign_in/repository/sign_in_shared_data_repository.dart';
import 'package:inject/inject.dart';

/// [ModifySharedDataRepository] closely mirrors [SignInSharedDataRepository]
/// but will allow the entire context to
@provide
class ModifySharedDataRepository extends SignInSharedDataRepository {}
