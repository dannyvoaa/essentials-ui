import 'dart:async';

import 'package:aae/assets/aae_icons.dart';
import 'package:aae/theme/colors.dart';
import 'package:flutter/material.dart';

class AirportPickerHeader extends StatelessWidget {
  final _Debouncer _debouncer = _Debouncer();
  final Function(String) onFilterChanged;

  AirportPickerHeader({@required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Select airport",
                  style: TextStyle(
                    fontSize: 21,
                    color: const Color(0xff627a88),
                    fontFamily: 'AmericanSans Medium',
                    fontWeight: FontWeight.w500,
                  )
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                      Icons.clear,
                      size: 20,
                      color: AaeColors.lightGray
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xffe7ecef),
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              color: AaeColors.white100,
            ),
            child: TextField(
              onChanged: (filter) {
                // this will ensure that the filter action is only performed
                // after the user has stopped typing for 500ms
                _debouncer.run(
                  delay: 500,
                  action: () => onFilterChanged(filter)
                );
              },
              decoration: InputDecoration(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      AmericanIconsv4_6.search,
                      size: 20,
                      color: AaeColors.ultraLightGray,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'City/airport search',
              ),
            ),
          )
        )
      ],
    );
  }
}

/// Simple class to perform an action only after an event has stopped occurring
/// for the given number of milliseconds.
class _Debouncer {
  Timer _timer;

  run({int delay, VoidCallback action}) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: delay), action);
  }
}