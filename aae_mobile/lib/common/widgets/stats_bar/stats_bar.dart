import 'package:aae/theme/colors.dart';
import 'package:aae/theme/typography.dart';
import 'package:flutter/material.dart';

class StatsBar extends StatelessWidget {
  //TODO (rpaglinawan): change this data structure once we have lock in how the
  //JSON would return
  final Map<String, Map<String, String>> _data = {
    "AAL": {"40.23": "increase"},
    "D0": {"80.9%": "decrease"},
    "A14": {"90.7%": "increase"},
    "CF": {"99.6%": "decrease"}
  };

  // StatsBar(this._data);

  @override
  Widget build(BuildContext context) => Container(
        color: Color(0xFFD0DAE0),
        height: 32,
        child: Row(
          children: buildStatsBar(),
        ),
      );

  List<Widget> buildStatsBar() {
    List<Widget> statsWidget = [];

    for (String key in _data.keys) {
      _data.keys.first == key
          ? statsWidget.add(Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 30.0),
              child: RichText(
                text: TextSpan(
                  text: '$key: ',
                  style: AaeTextStyles.t2.copyWith(
                      color: AaeColors.black, fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${_data[key].keys.first}',
                      style: TextStyle(
                          fontSize: 11,
                          color: assignAttributeColor(_data[key].values.first)),
                    ),
                  ],
                ),
              ),
            ))
          : statsWidget.add(Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: RichText(
                text: TextSpan(
                  text: '$key: ',
                  style: AaeTextStyles.t2.copyWith(
                      color: AaeColors.black, fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${_data[key].keys.first}',
                      style: TextStyle(
                          fontSize: 11,
                          color: assignAttributeColor(_data[key].values.first)),
                    ),
                  ],
                ),
              ),
            ));
    }
    return statsWidget;
  }

  Color assignAttributeColor(String attribute) {
    return attribute == 'increase' ? Colors.green : Colors.red;
  }
}
