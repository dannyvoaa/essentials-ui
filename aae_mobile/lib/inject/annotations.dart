import 'package:inject/inject.dart';

const providedServiceList = Qualifier(#providedServiceList);
const lifecycleServiceList = Qualifier(#lifecycleServiceList);
const repositoryList = Qualifier(#repositoryList);
const deepLink = Qualifier(#deepLink);

// State machines:
const signInHsm = Qualifier(#signInHsm);
const modifySettings = Qualifier(#modifySettingsHsm);
