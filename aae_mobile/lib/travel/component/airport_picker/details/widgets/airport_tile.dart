import 'package:aae/model/airport.dart';
import 'package:aae/theme/typography.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

class AirportTile extends StatelessWidget {
  final Airport airport;
  final Function() onClicked;

  AirportTile({@required this.airport, @required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Padding(
          padding: EdgeInsets.all(4),
          child: Container(
            margin: EdgeInsets.only(
              left: 8,
            ),
            padding: EdgeInsets.only(
              bottom: 8,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  color: const Color(0xffe7ecef),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: Text(
                      airport.code,
                      style: AaeTextStyles.title20Reg160.copyWith(
                        color: Color.fromRGBO(54, 73, 90, 1.0),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'AmericanSans',
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Text(
                    airport.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: AaeTextStyles.title20Reg160.copyWith(
                      fontSize: 16,
                      fontFamily: 'AmericanSans',
                      color: Color(0xFF627A88),
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
