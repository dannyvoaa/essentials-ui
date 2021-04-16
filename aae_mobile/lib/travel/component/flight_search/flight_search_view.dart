import 'package:aae/assets/aae_icons.dart';
import 'package:aae/model/flight_search.dart';
import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/travel/component/flight_status/details/flight_status_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'flight_search_view_model.dart';

class FlightSearchView extends StatelessWidget {
  final FlightSearchViewModel viewModel;
  final Function(BuildContext, String, String, String) searchType;
  final String searchField1;
  final String searchField2;
  final String searchDate;

  FlightSearchView(
      {@required this.viewModel,
      this.searchType,
      this.searchField1,
      this.searchField2,
      this.searchDate});

  @override
  Widget build(BuildContext context) {
    return _buildFlightSearchContainer(context);
  }

  Widget _buildFlightSearchContainer(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildFlightSearchHeader(context),
            _buildFlightSearchBody(context, searchType),
          ],
        ),
      ),
    ));
  }

  _buildFlightSearchHeader(BuildContext context) {
    FlightRoute flightRoute = viewModel.flightSearch.flightRoutes[0];
    String origin = flightRoute.flightSegments[0].flightLegs[0].origin.code;
    String destination = flightRoute
        .flightSegments[flightRoute.flightSegments.length - 1]
        .flightLegs[0]
        .destination
        .code;
    String departureDate =
        flightRoute.flightSegments[0].flightLegs[0].scheduledDepartureDateTime;

    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 3),
        alignment: Alignment.topLeft,
        child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
            child: Text(
              '$origin to $destination',
              style: AaeTextStyles.title32MediumGray,
              textAlign: TextAlign.left,
            )),
      ),
      Container(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 23, right: 20, bottom: 20),
          child: Text(
            _convertStringToDate(departureDate),
            style: AaeTextStyles.subtitle18MediumGray,
            textAlign: TextAlign.left,
          ),
        ),
      )
    ]);
  }

  _buildFlightSearchBody(BuildContext context,
      Function(BuildContext p1, String p2, String p3, String p4) searchType) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viewModel.flightSearch.flightRoutes.length,
          itemBuilder: (context, index) {
            return _buildGroupedListTiles(context,
                viewModel.flightSearch.flightRoutes[index], searchType);
          }),
    );
  }
}

_buildGroupedListTiles(BuildContext context, FlightRoute flightRoute,
    Function(BuildContext p1, String p2, String p3, String p4) searchType) {
  List<Widget> list = new List<Widget>();

  // logic to group segment tiles by routes
  for (FlightSegment flightSegment in flightRoute.flightSegments) {
    if (flightSegment.flightLegs.length == 0) {
      return Container();
    }
    list.add(_buildSingleListTile(context, flightSegment, searchType));
  }

  return Padding(
      padding: const EdgeInsets.only(
          top: 0,
          bottom: AaeDimens.smallCardVerticalContentPadding,
          left: 3,
          right: 3),
      child: Container(
        child: Column(children: list),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29131313),
              offset: Offset(0, 2),
              blurRadius: 3,
            ),
          ],
        ),
      ));
}

_buildSingleListTile(BuildContext context, FlightSegment flightSegment,
    Function(BuildContext p1, String p2, String p3, String p4) searchType) {
  return new Material(
      child: new InkWell(
          onTap: () {
            searchType(
                context,
                flightSegment.flightLegs[0].origin.code,
                flightSegment.flightNumber,
                flightSegment.flightLegs[0].scheduledDepartureDateTime
                    .substring(0, 10));
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            title: _buildListTileContent(
              context,
              flightSegment.flightNumber,
              flightSegment.flightLegs[0].origin.code,
              flightSegment.flightLegs[0].destination.code,
              flightSegment.flightLegs[0].scheduledDepartureDateTime,
              flightSegment.flightLegs[0].scheduledArrivalDateTime,
            ),
          )));
}

_buildListTileContent(
    BuildContext context,
    String flightNumber,
    String searchField1,
    String searchField2,
    String originDepartureTIme,
    String destinationDepartureTime) {
  return Container(
      child: Row(children: <Widget>[
    Flexible(
      flex: 1,
      child: Center(
        child: Column(
          children: [
            Container(
              height: 18,
              width: 18,
              padding: EdgeInsets.only(right: 2),
              child: Image.asset(
                'assets/common/american-airlines-eaagle-logo.png',
                scale: 20,
                fit: BoxFit.none,
              ),
            ),
            Container(
                //                color: AaeColors.green,
                padding: EdgeInsets.only(top: 5, bottom: 3),
                child: Text(flightNumber, style: AaeTextStyles.body14)),
          ],
        ),
      ),
    ),
    Expanded(
      flex: 8,
      child: FlightSearchCardBody(
          searchField1: searchField1,
          searchField2: searchField2,
          originDepartureTime: originDepartureTIme,
          destinationDepartureTime: destinationDepartureTime),
    ),
    Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
              padding: const EdgeInsets.all(0.0),
              width: 20.0, // you can adjust the width as you need
              child: Icon(Icons.arrow_forward_ios, color: AaeColors.lightGray)),
        ))
  ]));
}

_convertStringToDate(String strDate) {
  DateTime todayDate = DateTime.parse(strDate);
  final df = new DateFormat('EEEEE, MMMM d, yyyy');
  String date = df.format(todayDate);
  return date;
}

class FlightSearchCardBody extends StatelessWidget {
  final Function(BuildContext, String, String, String) searchType;
  final String searchField1;
  final String searchField2;
  final String originDepartureTime;
  final String destinationDepartureTime;

  const FlightSearchCardBody(
      {this.searchType,
      this.searchField1,
      this.searchField2,
      this.originDepartureTime,
      this.destinationDepartureTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 35, bottom: 0, top: 0),
      child: Row(
        children: [
          FlightSearchCardBodyColumn(
              _formatDate(originDepartureTime), searchField1),
          _buildArrowIcon(true),
          FlightSearchCardBodyColumn(
              _formatDate(destinationDepartureTime), searchField2),
        ],
      ),
    );
  }

  String _formatDate(String time) {
    if (time.isNotEmpty) {
      //remove time zone
      time = time.substring(0, time.length - 6);

      DateTime dateTime = DateTime.parse(time);
      String formattedDate = DateFormat('h:mm a').format(dateTime);
      return formattedDate;
    } else {
      return time;
    }
  }

  Widget _buildArrowIcon(bool arrowIcon) {
    if (arrowIcon) {
      return Container(
        alignment: Alignment.topCenter,
        height: 45,
        padding: EdgeInsets.only(top: 2, left: 6, right: 20),
        child: Icon(
          AmericanIconsv4_6.arrow_right,
          color: AaeColors.gray,
          size: 20,
        ),
      );
    } else {
      return Container();
    }
  }
}

class FlightSearchCardBodyColumn extends StatelessWidget {
  final String time;
  final String location;

  FlightSearchCardBodyColumn(this.time, this.location);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 0),
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: Container(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(time, style: AaeTextStyles.subtitle15Med)),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 0),
                  child: Text(location, style: AaeTextStyles.body14),
                ),
              ],
            )
          ],
        ));
  }
}
