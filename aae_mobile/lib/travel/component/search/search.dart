import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../search/search_form.dart';

class Search extends StatelessWidget {
  Search({this.title, this.searchType1, this.searchType2, this.calendarLength});

  final String title;
  final Function(BuildContext, String, String, String) searchType1;
  final Function(BuildContext, String, String, String) searchType2;
  var calendarLength;

  static const searchHeaderText = TextStyle(
    fontSize: 15,
    color: AaeColors.darkGray,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_buildHeader(), _buildSearchBox(context)]),
      padding: const EdgeInsets.all(20.0),
    ));
  }

  _buildHeader() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(
            this.title,
            style: AaeTextStyles.travelHeader,
            textAlign: TextAlign.left,
          ),
        ));
  }

  _buildSearchBox(BuildContext context) {
    return Container(
        width: double.infinity,
        //need to remove hardcoded height
        height: 400,
        child: DefaultTabController(
          length: 2,
          child: Container(
            child: Scaffold(
              backgroundColor: AaeColors.white,
              appBar: _buildAppBar(),
              body: TabBarView(
                children: [
                  SearchForm(
                      searchType: searchType1,
                      searchField1: 'To',
                      searchHint1: 'City/airport',
                      searchFieldType1: TextInputType.text,
                      searchField1Validation: 'Arrival city is required',
                      searchField1ValidationLength: 2,
                      searchField2: 'From',
                      searchHint2: 'City/airport',
                      searchFieldType2: TextInputType.text,
                      searchField2Validation: 'Departure city is required',
                      searchField2ValidationLength: 2,
                      calendarLength: calendarLength),
                  SearchForm(
                      searchType: searchType2,
                      searchField1: 'Flight number',
                      searchHint1: '',
                      searchFieldType1: TextInputType.number,
                      searchField1Validation: 'Enter a valid flight number',
                      searchField1ValidationLength: 0,
                      searchField2: 'From',
                      searchHint2: 'City/airport',
                      searchFieldType2: TextInputType.text,
                      searchField2Validation: 'Departure city is required',
                      searchField2ValidationLength: 2,
                      calendarLength: calendarLength),
                ],
              ),
            ),
          ),
        ),
        //need to fix box decoration so it's not hardcoded
        decoration: _buildBoxDecoration());
  }

  _buildAppBar() {
    return AppBar(
        backgroundColor: AaeColors.white,
        elevation: 0,
        bottom: new PreferredSize(
          child: new Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                child: TabBar(
                  labelColor: AaeColors.black,
                  indicatorColor: AaeColors.blue,
                  indicatorWeight: 3.0,
                  tabs: [
                    Tab(
                        child: Text('City/airport',
                            style: searchHeaderText,
                            textAlign: TextAlign.left)),
                    Tab(
                        child: Text('Flight number',
                            style: searchHeaderText,
                            textAlign: TextAlign.left)),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: AaeColors.gray),
                ))),
          ),
          preferredSize: null,
        ));
  }

  _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3.0),
      color: AaeColors.black,
      boxShadow: [
        BoxShadow(
          color: AaeColors.ultraLightGray,
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );
  }
}
