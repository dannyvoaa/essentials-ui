import 'dart:ui';

import 'package:aae/navigation/paage_provider.dart';
import 'package:aae/theme/colors.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          elevation: 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Text(
                  'Top Stories',
                  style: TextStyle(
                      fontSize: 18,
                      color: AaeColors.darkBlue,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Card(
                  shape: Border(),
                  elevation: 8,
                  color: Colors.white,
                  child: SizedBox(
                    width: 360,
                    height: 284,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(
                            'https://www.aa.com/content/images/homepage/mobile-hero/en_US/Airplane-1.png'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4),
                              child: Text(
                                'Article Title',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(49, 128, 193, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 4.0, top: 4),
                                  child: Icon(Icons.thumb_up),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8.0, top: 4),
                                  child: Icon(Icons.bookmark_border),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 4),
                                      child: Text(
                                        'Lorem ipsum dolor sit amet, consectetur '
                                        'adipiscing elit, sed do eiusmod tempor incididunt '
                                        'ut labore et dolore magna aliqua. Ut enim ad minim '
                                        '\n veniam, quis nostrud exercitation ullamco '
                                        'laboris nisi ut aliquip ex ea commodo consequat. '
                                        'Duis aute irure dolor in reprehenderit in voluptate .'
                                        'velit esse cillum dolore eu fugiat nulla pariatur. '
                                        'Excepteur sint occaecat cupidatat non proident, sunt '
                                        'in culpa qui officia deserunt mollit anim id est laborum.',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 90,
                            height: 25,
                            color: Colors.blue,
                            child: InkWell(
                              onTap: () {},
                              splashColor: Colors.green,
                              child: Center(
                                  child: Text(
                                'Read more',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                child: Text(
                  'For You',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(40, 86, 138, 1),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Card(
                  shape: Border(),
                  elevation: 8,
                  color: Colors.white,
                  child: SizedBox(
                    width: 360,
                    height: 284,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                child: Text(
                  'Video Center',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(40, 86, 138, 1),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Card(
                  shape: Border(),
                  elevation: 8,
                  color: Colors.white,
                  child: SizedBox(
                    width: 360,
                    height: 284,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                child: Text(
                  'Network Updates',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(40, 86, 138, 1),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                child: Card(
                  shape: Border(),
                  elevation: 8,
                  color: Colors.white,
                  child: SizedBox(
                    width: 360,
                    height: 284,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageProvider implements PageProvider {
  @override
  WidgetBuilder providePageBuilder(BuildContext context) {
    return (context) => HomePage();
  }
}
