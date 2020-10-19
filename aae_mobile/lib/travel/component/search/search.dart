import 'package:aae/theme/colors.dart';
import 'package:aae/theme/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../search/search_form.dart';

class Search<T> extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Search({this.context, this.title});

  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return _buildSearchBox(context);
  }

  _buildSearchBox(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            //?
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      this.title,
                      style: TextStyle(
                        fontSize: 15,
                        color: AaeColors.blue,
                        fontWeight: FontWeight.w700,
                        height: 2.6666666666666665,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  )),
              Container(
                width: double.infinity,
                height: 400,
                child: DefaultTabController(
                  length: 2,
                  child: Container(
                    child: Scaffold(
                      backgroundColor: AaeColors.white,
                      appBar: new AppBar(
                          backgroundColor: AaeColors.white,
                          elevation: 0,
                          bottom: new PreferredSize(
                            child: new Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: TabBar(
                                  labelColor: AaeColors.black,
                                  indicatorColor: AaeColors.blue,
                                  indicatorWeight: 3.0,
                                  tabs: [
                                    Tab(
                                        child: Text('City/airport',
                                            style: TextStyle(
                                              fontFamily: 'AmericanSans',
                                              fontSize: 15,
                                              color: const Color(0xff36495a),
                                              height: 1.6666666666666667,
                                            ),
                                            textAlign: TextAlign.left)),
                                    Tab(
                                        child: Text('Flight number',
                                            style: TextStyle(
                                              fontFamily: 'AmericanSans',
                                              fontSize: 15,
                                              color: const Color(0xff36495a),
                                              height: 1.6666666666666667,
                                            ),
                                            textAlign: TextAlign.left)),
                                  ],
                                )),
                            preferredSize: null,
                          )),
                      body:
                      TabBarView(
                        children: [
                          SearchForm(
                              searchField1: 'To',
                              searchHint1: 'City/airport',
                              searchField2: 'From',
                              searchHint2: 'City/airport'),
                          SearchForm(
                              searchField1: 'Flight number',
                              searchHint1: '',
                              searchField2: 'From',
                              searchHint2: 'City/airport'),
                        ],
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
      padding: const EdgeInsets.all(16.0),
    );
  }
}
