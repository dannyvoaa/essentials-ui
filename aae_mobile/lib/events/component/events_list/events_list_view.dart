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
        DateFormat.MMMMEEEEd('en_US').format(DateTime.now()),
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
          return Container(
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
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        '${DateTime.fromMicrosecondsSinceEpoch(viewModel.events[index].startDate)}',
                        style: AaeTextStyles.body(boolDefaultHeight: true),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${DateTime.fromMicrosecondsSinceEpoch(viewModel.events[index].endDate)}',
                        style: AaeTextStyles.body(boolDefaultHeight: true),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                  ),
                  margin: EdgeInsets.only(
                    right: AaeDimens.baseUnit,
                  ),
                ),
                Flexible(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          viewModel.events[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AaeTextStyles.headline(boolDefaultHeight: true),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          viewModel.events[index].venue,
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
          );
        },
      ),
    );
  }
}
