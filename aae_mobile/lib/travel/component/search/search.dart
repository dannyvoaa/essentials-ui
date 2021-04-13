import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'search_form.dart';

class Search extends StatelessWidget {
  Search({this.title, this.searchType1, this.searchType2, this.calendarLength});

  final String title;
  final Function(BuildContext, String, String, String) searchType1;
  final Function(BuildContext, String, String, String) searchType2;
  var calendarLength;

  static const subtitle15 = TextStyle(
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
          children: <Widget>[_buildSearchBox(context)]),
      padding: const EdgeInsets.all(20.0),
    ));
  }

  _buildSearchBox(BuildContext context) {
    return Container(
        width: double.infinity,
        //need to remove hardcoded height post MVP
        height: 380,
        child: DefaultTabController(
          length: 2,
          child: Container(
            child: Scaffold(
              backgroundColor: AaeColors.white100,
              appBar: _buildAppBar(),
              body: Padding( padding: EdgeInsets.only(top: 10),
                child: TabBarView(
                children: [
                  SearchForm(
                      searchType: searchType1,
                      searchField1: 'From',
                      searchHint1: 'City/airport',
                      searchFieldType1: SearchFormFieldType.airport,
                      searchField1Validation: 'Departure city is required',
                      searchField1ValidationLength: 2,
                      calendarLength: calendarLength,
                      searchField2: 'To',
                      searchHint2: 'City/airport',
                      searchFieldType2: SearchFormFieldType.airport,
                      searchField2Validation: 'Arrival city is required',
                      searchField2ValidationLength: 2),
                  SearchForm(
                    searchType: searchType2,
                    searchField1: 'From',
                    searchHint1: 'City/airport',
                    searchFieldType1: SearchFormFieldType.airport,
                    searchField1Validation: 'Departure city is required',
                    searchField1ValidationLength: 2,
                    calendarLength: calendarLength,
                    searchField2: 'Flight number',
                    searchHint2: '',
                    searchFieldType2: SearchFormFieldType.number,
                    searchField2Validation: 'Enter a valid flight number',
                    searchField2ValidationLength: 0,
                  ),
                ],
              ),),
            ),
          ),
        ),
        //need to fix box decoration so it's not hardcoded
        decoration: _buildBoxDecoration());
  }

  _buildAppBar() {
    return AppBar(
        backgroundColor: AaeColors.white100,
        elevation: 0,
        bottom: new PreferredSize(
          child: new Container(
            padding: EdgeInsets.only(left: 20, right: 20,),
            child: Container(
                child: TabBar(
                  labelColor: AaeColors.darkGray,
                  indicatorColor: AaeColors.blue,
                  indicatorWeight: 3.0,
                  tabs: [
                    Tab(
                      child: Container(
                          padding: EdgeInsets.only(bottom: 5),
                          alignment: Alignment.bottomCenter,
                          child: Text('City/airport',
                              style: AaeTextStyles.subtitle15,
                              textAlign: TextAlign.left)),
                    ),
                    Tab(
                      child: Container(
                          padding: EdgeInsets.only(bottom: 5),
                          alignment: Alignment.bottomCenter,
                          child: Text('Flight number',
                              style: AaeTextStyles.subtitle15,
                              textAlign: TextAlign.left)),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Color.fromRGBO(208, 218, 224, 1.0)),
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
          color: AaeColors.lightGray,
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );
  }
}
