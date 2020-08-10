import 'package:aae/events/component/events_list/events_list_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aae/assets/aae_icons.dart';

class EventsListView extends StatelessWidget {
  final EventsListViewModel viewModel;

  EventsListView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildSelectedDated(context),
        _buildEventsList(context)
      ],
    );
  }

  Widget _buildSelectedDated(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.0, right: 6.0),
      child: Container(
        alignment: Alignment.centerLeft,
//      height: 40,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
//              color: AaeColors.lightGray,
              offset: Offset(0.2, 2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        margin: EdgeInsets.only(
          bottom: AaeDimens.baseUnit,
          top: AaeDimens.baseUnit,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Container(
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
            ),
            width: double.infinity,
            height: 36,
            color: AaeColors.white,
            child: Text(
              DateFormat.yMMMMEEEEd('en_US').format(viewModel.observingDate),
              style: AaeTextStyles.description(),
            ),
          ),
        ),
      ),
    );
  }

  //TODO: - Make match spec
  Widget _buildEventsList(BuildContext context) {
    String dateFormatter(i) {
      var timeStamp = viewModel.events[i].start;
      var endTimeStamp = viewModel.events[i].end;
      var format = new DateFormat('EEEE, MMM d | hh:mm a');
      var formatEnd = new DateFormat('hh:mm a');
      var date = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      var end = new DateTime.fromMillisecondsSinceEpoch(endTimeStamp * 1000);

      var start = format.format(date).toString();
      var endTime = formatEnd.format(end).toString();

      var dateline = start + " - " + endTime;
      return dateline;
    }

    return Expanded(
      child: viewModel.events.length == 0
          ? Container(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Nothing planned today.',
                  style: AaeTextStyles.description(),
                ),
              ),
            )
          : ListView.separated(
//              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                left: 6.0,
                right: 6.0,
              ),
              shrinkWrap: true,
              itemCount: viewModel.events.length,
              separatorBuilder: (_, __) {
                return Container(
                  height: AaeDimens.smallCardVerticalContentPadding,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AaeColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.2, 2),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: InkWell(
//              borderRadius: BorderRadius.circular(30),
                    onTap: () {
//                      showBottomSheet(
                      showModalBottomSheet(
//                      enableDrag: true,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
//                        height: double.infinity,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.only(top:24, bottom:12, left:12, right:12,),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(top:30,),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: GestureDetector(
                                                onTap: () => Navigator.of(context).pop(),
                                                child: Icon(
                                                  IconData(57676, fontFamily: 'MaterialIcons'),
                                                  size: 20,
                                                  color: AaeColors.darkGray,
                                                ),
                                              ),
//                                            height: 12,
                                              margin: EdgeInsets.only(
                                                right: AaeDimens.baseUnit,
                                                bottom:30,
                                                top: 4,
                                              ),
                                              width: AaeDimens.baseUnit,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                          decoration: BoxDecoration(
                                            color: AaeColors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                          height: 12,
                                          margin: EdgeInsets.only(
                                            right: AaeDimens.baseUnit,
                                            top: 4,
                                          ),
                                          width: AaeDimens.baseUnit,
                                            ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                viewModel.events[index].eventName,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: AaeTextStyles.eventTitle(
                                                    boolDefaultHeight: true),
                                              ),
                                              Text(
                                                dateFormatter(index),
                                                overflow: TextOverflow.ellipsis,
                                                style: AaeTextStyles.eventDate(
                                                    boolDefaultHeight: true),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:30),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Icon(
                                              AaeIcons.marker,
                                              size: 16,
                                              color: AaeColors.darkGray,
                                            ),
                                            height: 12,
                                            margin: EdgeInsets.only(
                                              right: AaeDimens.baseUnit,
                                            ),
                                            width: AaeDimens.baseUnit,
                                          ),
                                          Text(
                                            viewModel.events[index].locationVenue,
                                            overflow: TextOverflow.ellipsis,
                                            style: AaeTextStyles.eventText(
                                                boolDefaultHeight: true),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:30),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Icon(
                                              AaeIconsv4.more,
                                              size: 12,
                                              color: AaeColors.darkGray,
                                            ),
                                            height: 12,
                                            margin: EdgeInsets.only(
                                              right: AaeDimens.baseUnit,
                                            ),
                                            width: AaeDimens.baseUnit,
                                          ),
                                          Flexible(
                                            child: Text(
                                              viewModel.events[index].eventDescription,
//                                    overflow: TextOverflow.ellipsis,
                                              style: AaeTextStyles.eventText(
                                                  boolDefaultHeight: true),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: AaeColors.blue,
                              shape: BoxShape.circle,
                            ),
                            height: 12,
                            margin: EdgeInsets.only(
                              right: AaeDimens.baseUnit / 2,
                            ),
                            width: AaeDimens.baseUnit * 3,
                          ),
                          Flexible(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    DateFormat.jm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            viewModel.events[index].start *
                                                1000)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AaeTextStyles.calendarSummary(
                                        boolDefaultHeight: true),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    DateFormat.jm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            viewModel.events[index].end *
                                                1000)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AaeTextStyles.calendarSummary(
                                        boolDefaultHeight: true),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                          Container(
                            width: 25,
                            height: 25,
                          ),
                          Flexible(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    viewModel.events[index].eventName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AaeTextStyles.calendarSummaryBold(
                                        boolDefaultHeight: true),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    viewModel.events[index].locationVenue,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AaeTextStyles.calendarSummary(
                                        boolDefaultHeight: true),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
//                color: AaeColors.white,
                      margin: EdgeInsets.only(
                        bottom: AaeDimens.baseUnit / 2,
                        top: AaeDimens.baseUnit / 2,
                      ),
                      padding: EdgeInsets.all(
                        AaeDimens.baseUnit,
                      ),
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
