import 'package:aae/common/widgets/drawer/aae_drawer.dart';
import 'package:aae/events/component/events_list/events_list_component.dart';
import 'package:aae/events/page/caledar.dart';
import 'package:aae/navigation/page_provider.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Setup any required variables
    DateTime datePage = DateTime.now();

    DateTime dateBuilder = DateTime.parse(
        '${datePage.year}-${datePage.month.toString().padLeft(2, '0')}-01T00:00:00Z');

    // Check to see if the year should be displayed
    // - The year is only displayed when the paged date's year is not the same as the current date's year
    String stringMonthYear = dateBuilder.year == DateTime.now().year
        ? DateFormat.MMMM().format(dateBuilder)
        : DateFormat.yMMMM().format(dateBuilder);
    return Scaffold(
      drawer: AaeDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AaeDimens.baseUnit),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      child: Icon(
                        Icons.chevron_left,
                        color: AaeColors.blue,
                      ),
                      height: AaeDimens.baseUnit3x,
                      width: AaeDimens.baseUnit3x,
                    ),
                    onTap: () {
                      // Execute the on-tap action
                    },
                  ),
                  Text(
                    stringMonthYear,
                    style: AaeTextStyles.title(),
                  ),
                  InkWell(
                    child: Container(
                      child: Icon(
                        Icons.chevron_right,
                        color: AaeColors.blue,
                      ),
                      height: AaeDimens.baseUnit3x,
                      width: AaeDimens.baseUnit3x,
                    ),
                    onTap: () {
                      // Execute the on-tap action
                    },
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              color: AaeColors.white,
              margin: EdgeInsets.only(
                left: 0,
                top: AaeDimens.baseUnit,
                right: 0,
                bottom: AaeDimens.baseUnit,
              ),
            ),
            Calendar(
              datePage: DateTime.now(),
              dateSelected: DateTime.now(),
              listDateEvents: [DateTime.now()],
            ),
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
