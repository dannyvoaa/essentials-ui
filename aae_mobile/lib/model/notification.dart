library notification;

import 'package:built_value/built_value.dart';

part 'notification.g.dart';

abstract class Notification
    implements Built<Notification, NotificationBuilder> {
  Notification._();

  String get title;

  String get body;

  factory Notification([updates(NotificationBuilder b)]) = _$Notification;
}
