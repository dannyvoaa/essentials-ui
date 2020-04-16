import 'package:aae/events/component/events_list/events_list_view_model.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsListView extends StatelessWidget {
  final EventsListViewModel viewModel;

  EventsListView({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSelectedDated(context),
        _buildEventsList(context)
      ],
    );
  }

  Widget _buildSelectedDated(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        DateFormat.MMMMEEEEd('en_US').format(viewModel.observingDate),
        style: AaeTextStyles.description(),
      ),
      color: AaeColors.white,
      margin: EdgeInsets.only(
        bottom: AaeDimens.baseUnit,
      ),
      padding: EdgeInsets.all(
        AaeDimens.baseUnit,
      ),
      width: double.infinity,
    );
  }

  //TODO: (kiheke) - Make match spec
  Widget _buildEventsList(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.events.length,
        separatorBuilder: (_, __) {
          return Container(
            height: AaeDimens.smallCardVerticalContentPadding,
          );
        },
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                  enableDrag: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            viewModel.events[index].eventName,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AaeTextStyles.headline(boolDefaultHeight: true),
                          ),
                          Text(
                            viewModel.events[index].locationVenue,
                            overflow: TextOverflow.ellipsis,
                            style: AaeTextStyles.body(boolDefaultHeight: true),
                          ),
                          Text(
                            '${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(viewModel.events[index].start * 1000))}'
                            ' to '
                            '${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(viewModel.events[index].end * 1000))}',
                            style: AaeTextStyles.body(boolDefaultHeight: true),
                          ),
                        ],
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
                    height: AaeDimens.baseUnit,
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
                                    viewModel.events[index].start * 1000)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AaeTextStyles.body(boolDefaultHeight: true),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            DateFormat.jm().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    viewModel.events[index].end * 1000)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AaeTextStyles.body(boolDefaultHeight: true),
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
                            style:
                                AaeTextStyles.headline(boolDefaultHeight: true),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            viewModel.events[index].locationVenue,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AaeTextStyles.body(boolDefaultHeight: true),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              color: AaeColors.white,
              margin: EdgeInsets.only(
                bottom: AaeDimens.baseUnit,
              ),
              padding: EdgeInsets.all(
                AaeDimens.baseUnit,
              ),
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
