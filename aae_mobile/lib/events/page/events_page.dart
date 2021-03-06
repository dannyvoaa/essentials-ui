import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/events/component/calendar/calendar_component.dart';
import 'package:aae/events/component/events_list/events_list_component.dart';
import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AaeDrawer(),
      appBar: AppBar(
        backgroundColor: AaeColors.blue,
        automaticallyImplyLeading: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AaeDimens.baseUnit),
        child: Column(
          children: <Widget>[
            CalendarComponent(),
            Expanded(child: EventsListComponent()),
          ],
        ),
      ),
    );
  }
}

class EventsPageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => EventsPage();
  }
}
