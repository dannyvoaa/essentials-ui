import 'package:flutter/material.dart';

abstract class PageProvider {
  WidgetBuilder providePageBuilder(BuildContext context);
}
