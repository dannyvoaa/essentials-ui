import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';
import '../search/search_form.dart';

class Search<T> extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Search({this.context});

  final BuildContext context;

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
                        "Flight status",
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
                  child: SizedBox(
                      height: 1000,
                      width: double.infinity,
                      child: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          backgroundColor: AaeColors.white,
                          appBar: TabBar(
                            isScrollable: false,
                            labelColor: AaeColors.black,
                            indicatorColor: AaeColors.blue,
                            tabs: [
                              Tab(text: "City/airport"),
                              Tab(text: "Flight number"),
                            ],
                          ),
                          body: TabBarView(
                            children: [
                              SearchForm(),
                              SearchForm(),
                            ],
                          ),
                        ),
                      )),
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
                )
              ],
            )),
        padding: const EdgeInsets.all(16.0));
  }
}
